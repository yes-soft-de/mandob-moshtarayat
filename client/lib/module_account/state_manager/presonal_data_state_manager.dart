import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_account/request/profile_request.dart';
import 'package:mandob_moshtarayat/module_account/service/account_service.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/presonal_data_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/personal_data/personal_data_loaded_state.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/personal_data/personal_data_loading_state.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/personal_data/personal_data_state.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class PersonalDataStateManager {
  final AccountService _accountService;
  final ImageUploadService _uploadService;
  PersonalDataStateManager(this._accountService, this._uploadService);
  final PublishSubject<PersonalDataState> _stateSubject =
      PublishSubject<PersonalDataState>();

  Stream<PersonalDataState> get stateStream => _stateSubject.stream;

  void postClientProfile(
      PersonalDataScreenState screenState, ProfileRequest request) {
    _stateSubject.add(PersonalDataLoadingState(screenState));
    _accountService.postClientProfile(request).then((value) {
      if (value.hasError) {
        screenState.moveDecision(false, value.error!);
      } else {
        screenState.moveDecision(true);
      }
    });
  }

  void uploadImage(String imagePath, PersonalDataScreenState screenState,
      ProfileModel profileModel) {
    CustomFlushBarHelper.createSuccess(
        title: S.current.warnning,
        message: S.current.uploadingImagesPleaseWait,
        background: Theme.of(screenState.context).primaryColor,
        timeout: 1,
        top: true)
      ..show(screenState.context);
    _uploadService.uploadImage(imagePath).then((value) {
      if (value == null) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: S.current.uploadingImagesPleaseWait)
          ..show(screenState.context);
        _stateSubject.add(PersonalDataLoadedState(screenState, profileModel));
      } else {
        profileModel.image = value;
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.uploadImageSuccess)
          ..show(screenState.context);
        _stateSubject.add(PersonalDataLoadedState(screenState, profileModel));
      }
    });
  }
}

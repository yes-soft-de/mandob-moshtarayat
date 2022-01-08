import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/model/sub_categories_link_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/main_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/sub_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/service/linking_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/sub_categories_linking_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/state/sub_categories_linking/sub_categories_linking_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';

@injectable
class SubCategoriesLinkingStateManager {
  final LinkingService _categoriesService;
  final AuthService _authService;
  final ImageUploadService _imageUploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  SubCategoriesLinkingStateManager(
      this._categoriesService, this._authService, this._imageUploadService);

  void getSubCategoriesLinking(
      SubCategoriesLinkingScreenState screenState, String id) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getSubCategoriesLinking(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(SubCategoriesLinkingLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(SubCategoriesLinkingLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        SubCategoriesLinksModel model = value as SubCategoriesLinksModel;
        _stateSubject
            .add(SubCategoriesLinkingLoadedState(screenState, model.data));
      }
    });
  }

  void updateCategory(
      SubCategoriesLinkingScreenState screenState, SubLinkRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.updateSubLink(request).then((value) {
      if (value.hasError) {
        Navigator.of(screenState.context).pop();
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        Navigator.of(screenState.context).pop();
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: value.error ?? S.current.linkedSuccessfully)
            .show(screenState.context);
      }
    });
  }
}

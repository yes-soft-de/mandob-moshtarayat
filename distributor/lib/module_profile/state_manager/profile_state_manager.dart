import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/module_profile/service/profile_service.dart';
import 'package:mandob_moshtarayat/module_profile/ui/screen/profile_screen.dart';
import 'package:mandob_moshtarayat/module_profile/ui/state/mandob_profile/profile_loaded_state.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ProfileStateManager {
  final ProfileService _profileService;
  final ImageUploadService _uploadService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  ProfileStateManager(this._profileService, this._uploadService, this._authService);

  void getStore(ProfileScreenState screenState) {
    if (_authService.isLoggedIn) {
    _stateSubject.add(LoadingState(screenState));
    _profileService.getProfile().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            ProfileLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            ProfileLoadedState(screenState, null, empty: true));
      } else {
       ProfileModel model = value as ProfileModel;
        _stateSubject.add(ProfileLoadedState(screenState, model.data));
      }
    });
  }else{
      screenState.goToLogin();
    }
  }
//  void updateStore(StoreInfoScreenState screenState,CreateStoreRequest request){
//    if (request.image!.contains('/original-image/')) {
//      _stateSubject.add(LoadingState(screenState));
//      _storesService.updateStore(request).then((value){
//        if (value.hasError){
//          getStore(screenState);
//          CustomFlushBarHelper.createError(title:S.current.warnning, message:value.error??'')..show(screenState.context);
//        }
//        else {
//          getStore(screenState);
//          CustomFlushBarHelper.createSuccess(title:S.current.warnning, message:S.current.storeUpdatedSuccessfully)..show(screenState.context);
//        }
//      });
//    }
//    else {
//      _stateSubject.add(LoadingState(screenState));
//      _uploadService.uploadImage(request.image!).then((value){
//        if (value == null) {
//          getStore(screenState);
//          CustomFlushBarHelper.createError(title:S.current.warnning, message:S.current.errorUploadingImages)..show(screenState.context);
//        }
//        else {
//          request.image = value;
//          _storesService.updateStore(request).then((value){
//            if (value.hasError){
//              getStore(screenState);
//              CustomFlushBarHelper.createError(title:S.current.warnning, message:value.error??'')..show(screenState.context);
//            }
//            else {
//              getStore(screenState);
//              CustomFlushBarHelper.createSuccess(title:S.current.warnning, message:S.current.storeUpdatedSuccessfully)..show(screenState.context);
//            }
//          });
//        }
//      });
//    }
//  }
}

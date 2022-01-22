import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service.dart';
import 'package:mandob_moshtarayat/module_stores/service/store_service.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_loaded_state.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class StoreStateManager {
  final StoreService _profileService;
  final ImageUploadService _uploadService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreStateManager(this._profileService, this._uploadService, this._authService);

  void getStore(StoreScreenState screenState) {
    _stateSubject.add(StoreLoadedState(screenState));
  }

//  }else{
//      screenState.goToLogin();
//    }
//  }
//  void updateProfiel(ProfileScreenState screenState,CreateMandobRequest request){
//    if (request.image!.contains('/original-image/')) {
//      _stateSubject.add(LoadingState(screenState));
//      _profileService.updateProfile(request).then((value){
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
//          _profileService.updateProfile(request).then((value){
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

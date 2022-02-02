import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_init/service/init_account/init_account.service.dart';
import 'package:mandob_moshtarayat/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:mandob_moshtarayat/module_init/ui/state/init_account/init_account.state.dart';

import 'package:mandob_moshtarayat/module_init/ui/state/init_account_captain_profile_created/init_account_captain_profile_created.dart';import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat/module_init/ui/state/init_account_captain_init_profile/init_account_captain_init_profile.dart';
import 'package:mandob_moshtarayat/module_init/ui/state/init_account_captain_loading/init_account_captain_loading.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';

@injectable
class InitAccountStateManager {
  final InitAccountService _initAccountService;
  final AuthService _authService;
  final ImageUploadService _uploadService;



  final PublishSubject<InitAccountState> _stateSubject =
      PublishSubject<InitAccountState>();

  Stream<InitAccountState> get stateStream => _stateSubject.stream;

  InitAccountStateManager(
    this._initAccountService,
    this._authService,
    this._uploadService,
  );

  // void getRoleInit(InitAccountScreenState screen) {
  //       getCaptainScreen(screen);
  // }

  void submitProfile (CreateMandobRequest request,InitAccountScreenState screenState) {
    _stateSubject.add(
        InitAccountCaptainStateLoading(screenState, S.current.uploadingImages));
      _uploadService.uploadImage(request.image!)
    .then((value) {
      if (value != null) {
        request.image = value;
        _stateSubject.add(InitAccountCaptainStateLoading(
            screenState, S.current.submittingProfile));
        _initAccountService
            .createMandobProfile(request
        ).then((value) {
               if (value.hasError){
                 _stateSubject.add(InitAccountCaptainInitProfile(
                     screenState));
                 screenState.showMessage(value.error,false);
               }
               else {
//                 _authService.i();
                 _stateSubject.add(InitAccountStateProfileCreated(screenState));
               }
        });
      } else {
        _stateSubject.add(InitAccountCaptainInitProfile(
            screenState));
        screenState.showMessage(S.current.errorUploadingImages,false);
      }
    });
  }

  // void submitAccountNumber(String bankName, String bankAccountNumber,
  //     InitAccountScreenState screenState) {
  //   _stateSubject.add(
  //     InitAccountStateLoading(screenState),
  //   );
  //   _initAccountService
  //       .createBankDetails(bankName, bankAccountNumber)
  //       .then((value) {
  //     screenState.moveToOrders();
  //   });
  // }

  // void getCaptainScreen(InitAccountScreenState screenState) {
  //   _stateSubject.add(InitAccountCaptainInitProfile(screenState));
  // }
  void getStoreCategories(InitAccountScreenState screenState) {
//    _stateSubject.add(InitAccountStateFirstLoading(screenState));
//    _categoriesService.getStoreCategories().then((value) {
//      if (value.hasError) {
//        // _stateSubject.add(StoreCategoriesLoadedState(screenState,null,error: value.error));
//      } else if (value.isEmpty) {
//        _stateSubject.add(InitAccountCaptainInitProfile(screenState,[],));
//      } else {
//        StoreCategoriesModel model = value as StoreCategoriesModel;
//        _stateSubject.add(InitAccountCaptainInitProfile(screenState,model.data));
//      }
//    });
  }

}

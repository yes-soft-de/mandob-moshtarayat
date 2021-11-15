import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/model/company_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/create_company_profile.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/service/company_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/ui/screen/company_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/ui/state/company_profile/company_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/stores_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

@injectable
class CompanyProfileStateManager {
  final CompanyService _companyService;
  final AuthService _authService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CompanyProfileStateManager(this._authService, this._companyService);

  void getCompanyProfile(CompanyProfileScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _companyService.getCompanyProfile().then((value) {
      if (value.isEmpty) {
        _stateSubject.add(CompanyLoadedState(screenState, null, empty: true));
      } else if (value.hasError) {
        _stateSubject
            .add(CompanyLoadedState(screenState, null, error: value.error));
      } else {
        CompanyProfileModel model = value as CompanyProfileModel;
        _stateSubject.add(
            CompanyLoadedState(screenState, model.data, error: value.error));
      }
    });
  }

  void createProfile(
      CompanyProfileScreenState screenState, CreateCompanyProfile request) {
    _stateSubject.add(LoadingState(screenState));

    _companyService.createCompanyProfile(request).then((value) {
      if (value.hasError) {
        getCompanyProfile(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        getCompanyProfile(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.companyProfileCreatedSuccessfully)
          ..show(screenState.context);
      }
    });
  }

  void updateStore(
      CompanyProfileScreenState screenState, CreateCompanyProfile request) {
    _stateSubject.add(LoadingState(screenState));

    _companyService.UpdateCompanyProfile(request).then((value) {
      if (value.hasError) {
        getCompanyProfile(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        getCompanyProfile(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.companyProfileUpdatedSuccessfully)
          ..show(screenState.context);
      }
    });
  }
}

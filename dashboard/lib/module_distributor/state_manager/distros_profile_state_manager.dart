import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/di/di_config.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/profile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/request/accept_captain_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/service/distributer_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distros_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/state/distributors_profile/distributor_profile.dart';
import 'package:mandob_moshtarayat_dashboad/utils/global/global_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';

@injectable
class DistrosProfileStateManager {
  final DistributorService _distributorService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  DistrosProfileStateManager(this._distributorService);

  void getDistorProfile(DistributorProfileScreenState screenState, int captainId) {
    _stateSubject.add(LoadingState(screenState));
    _distributorService.getDistorProfile(captainId).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            DistributorProfileLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            DistributorProfileLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        ProfileModel _model = value as ProfileModel;
        _stateSubject.add(DistributorProfileLoadedState(screenState, _model.data));
      }
    });
  }

  void acceptDistroProfile(DistributorProfileScreenState screenState,
      int distroId, AcceptDistroRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _distributorService.enableDistro(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getDistorProfile(screenState, distroId);
      } else {
        getDistorProfile(screenState, distroId);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.distroUpdatedSuccessfully)
            .show(screenState.context);
        getIt<GlobalStateManager>().updateCaptainList();
      }
    });
  }
}

import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/service/distributer_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distros_balance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/state/distro_account_balance/distro_account_balance_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';

@injectable
class DistroBalanceStateManager {
  final DistributorService _distributorService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  DistroBalanceStateManager(this._distributorService);

  void getDistroBalance(DistroBalanceScreenState screenState, int captainId) {
    _stateSubject.add(LoadingState(screenState));
    Future.wait([
      _distributorService.getDistroBalance(captainId),
      _distributorService.getDistroBalanceLastMonth(captainId),
    ]).then((value) {
      if (value[0].hasError && value[1].hasError) {
        _stateSubject.add(DistroBalanceLoadedState(screenState, null, null,
            error: [value[0].error!, value[1].error!]));
      } else if (value[0].isEmpty && value[1].isEmpty) {
        _stateSubject.add(DistroBalanceLoadedState(screenState, null, null,
            empty: value.isEmpty));
      } else {
        BalanceModel _model = value[0] as BalanceModel;
        BalanceModel _modelLastMonth = value[1] as BalanceModel;

        _stateSubject.add(DistroBalanceLoadedState(
            screenState, _model.data, _modelLastMonth.data));
      }
    });
  }

  void getBalanceFilteredDate(
      DistroBalanceScreenState screenState,
      int captainId,
      AccountBalance captainBalance,
      AccountBalance captainBalanceLastMonth,
      String firstDate,
      String lastDate) {
    _stateSubject.add(LoadingState(screenState));
    _distributorService
        .getDistroSpecificDate(captainId, firstDate, lastDate)
        .then((value) {
      if (value.hasError) {
        _stateSubject.add(DistroBalanceLoadedState(
            screenState, captainBalance, captainBalanceLastMonth,
            error: [value.error!]));
      } else if (value.isEmpty) {
        _stateSubject.add(DistroBalanceLoadedState(
            screenState, captainBalance, captainBalanceLastMonth,
            empty: value.isEmpty));
      } else {
        BalanceModel _model = value as BalanceModel;
        _stateSubject.add(DistroBalanceLoadedState(
            screenState, captainBalance, captainBalanceLastMonth,
            specificCaptainBalance: _model.data));
      }
    });
  }
}

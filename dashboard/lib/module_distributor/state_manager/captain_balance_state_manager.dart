import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/service/captains_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captain_balance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/state/captain_account_balance/captain_account_balance_state.dart';

@injectable
class CaptainBalanceStateManager {
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CaptainBalanceStateManager(this._captainsService);

  void getCaptainBalance(CaptainBalanceScreenState screenState, int captainId) {
    _stateSubject.add(LoadingState(screenState));
    Future.wait([
      _captainsService.getCaptainBalance(captainId),
      _captainsService.getCaptainBalanceLastMonth(captainId),
    ]).then((value) {
      if (value[0].hasError && value[1].hasError) {
        _stateSubject.add(CaptainBalanceLoadedState(screenState, null, null,
            error: [value[0].error!, value[1].error!]));
      } else if (value[0].isEmpty && value[1].isEmpty) {
        _stateSubject.add(CaptainBalanceLoadedState(screenState, null, null,
            empty: value.isEmpty));
      } else {
        BalanceModel _model = value[0] as BalanceModel;
        BalanceModel _modelLastMonth = value[1] as BalanceModel;

        _stateSubject.add(CaptainBalanceLoadedState(
            screenState, _model.data, _modelLastMonth.data));
      }
    });
  }

  void getBalanceFilteredDate(
      CaptainBalanceScreenState screenState,
      int captainId,
      AccountBalance captainBalance,
      AccountBalance captainBalanceLastMonth,
      String firstDate,
      String lastDate) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService
        .getCaptainSpecificDate(captainId, firstDate, lastDate)
        .then((value) {
      if (value.hasError) {
        _stateSubject.add(CaptainBalanceLoadedState(
            screenState, captainBalance, captainBalanceLastMonth,
            error: [value.error!]));
      } else if (value.isEmpty) {
        _stateSubject.add(CaptainBalanceLoadedState(
            screenState, captainBalance, captainBalanceLastMonth,
            empty: value.isEmpty));
      } else {
        BalanceModel _model = value as BalanceModel;
        _stateSubject.add(CaptainBalanceLoadedState(
            screenState, captainBalance, captainBalanceLastMonth,
            specificCaptainBalance: _model.data));
      }
    });
  }
}

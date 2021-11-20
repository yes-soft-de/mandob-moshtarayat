import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/captain_model_payment_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/inActiveModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/service/captains_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captains_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/state/captain_list/captains_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/model/order_account_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/screen/order_accounts_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/state/order_account_loaded_state.dart';

@injectable
class OrdersAccountStateManager {
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  OrdersAccountStateManager(this._captainsService);

  void getCaptains(OrdersAccountScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getRemainingPayments().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            OrdersAccountLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            OrdersAccountLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        OrderAccountModel _model = value as OrderAccountModel;
        _stateSubject.add(OrdersAccountLoadedState(screenState, _model.data));
      }
    });
  }
}

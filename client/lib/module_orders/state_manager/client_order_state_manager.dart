import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/module_orders/service/orders_service.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/client_order_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/client_order/client_order_loading_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/client_order/client_order_state.dart';

@injectable
class ClientOrderStateManager {
  final OrdersService _OrdersService;
  final AuthService _authService;
  final PublishSubject<ClientOrderState> _stateSubject = PublishSubject();
  Stream<ClientOrderState> get stateStream => _stateSubject.stream;

  ClientOrderStateManager(this._OrdersService, this._authService);
  void postClientOrder(
      ClientOrderRequest request, ClientOrderScreenState screenState) {
    if (_authService.isLoggedIn) {
      _stateSubject.add(ClientLoadingState(screenState));
      _OrdersService.postClientOrder(request).then((value) {
        if (value.hasError) {
          screenState.moveDecision(false, value.error!);
        } else {
          screenState.needToPay(value.data);
        }
      });
    } else {
      screenState.goToLogin();
    }
  }
}

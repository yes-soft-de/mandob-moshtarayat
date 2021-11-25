import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/ongoing_orders/onGoing_orders_loading_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/ongoing_orders/ongoing_orders_empty_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/ongoing_orders/ongoing_orders_error_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/ongoing_orders/ongoing_orders_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_model.dart';
import 'package:mandob_moshtarayat/module_orders/service/orders_service.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/OngoingOrdersScreen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/ongoing_orders/ongoing_orders_loaded_state.dart';

@injectable
class OnGoingOrdersStateManager {
  final OrdersService _myOrdersService;
  final AuthService _authService;
  final PublishSubject<OngoingState> _stateSubject =
  PublishSubject<OngoingState>();

  Stream<OngoingState> get stateStream => _stateSubject.stream;

  OnGoingOrdersStateManager(
      this._myOrdersService, this._authService);

  StreamSubscription? newActionSubscription;

  void getOrders(OnGoingOrdersScreenState screenState) {
    if (_authService.isLoggedIn) {
      _stateSubject.add(OnGoingOrdersLoadingState(screenState));
      _myOrdersService.getOngoingOrders().then((value) {
        if (value.hasError) {
          print(value.error);
          _stateSubject.add(OnGoingOrdersErrorState(
              screenState, value.error ?? S.current.errorHappened,refresh: (){
                getOrders(screenState);
          }));
        } else if (value.isEmpty) {
          _stateSubject
              .add(OnGoingOrdersEmptyState(screenState, S.current.homeDataEmpty,refresh: (){
                getOrders(screenState);
          }));
        } else {
          OrderModel model = value as OrderModel;
          _stateSubject.add(OnGoingOrdersLoadedState(screenState, model.data));
        }
      });
    } else {
      screenState.goToLogin();
    }
  }

}

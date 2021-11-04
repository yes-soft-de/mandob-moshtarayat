import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/module_orders/model/deleted_order_status.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/module_orders/service/orders_service.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_details_screen.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/order_details_loaded_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/order_details_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/orders_details_empty_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/orders_details_error_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/orders_details_loading_state.dart';
import 'package:mandob_moshtarayat/utils/helpers/fire_store_helper.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class OrderDetailsStateManager {
  final OrdersService _ordersService;
  final PublishSubject<OrderDetailsState> _stateSubject = PublishSubject();

  Stream<OrderDetailsState> get stateStream => _stateSubject.stream;
  final FireStoreHelper _fireStoreHelper;

  OrderDetailsStateManager(this._ordersService, this._fireStoreHelper);

  StreamSubscription? newActionSubscription;

  void getOrderDetails(int id, OrderDetailsScreenState screenState) {
    _stateSubject.add(OrderDetailsLoadingState(screenState));
    _ordersService.getOrdersDetails(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(OrderDetailsErrorState(
            screenState, value.error ?? S.current.errorHappened, id));
      } else if (value.isEmpty) {
        _stateSubject.add(
            OrderDetailsEmptyState(screenState, S.current.homeDataEmpty, id));
      } else {
        _stateSubject.add(OrderDetailsLoadedState(screenState, value.data));
        initListening(screenState, id);
      }
    });
  }

  void deleteOrderDetails(int id, OrderDetailsScreenState screenState) {
    _stateSubject.add(OrderDetailsLoadingState(screenState));
    newActionSubscription?.cancel();
    _ordersService.deleteClientOrder(id).then((MyOrderState value) {
      if (value.hasError) {
        screenState.deleteMessage(
            false, value.error ?? S.current.errorHappened);
      } else {
        screenState.deleteMessage(true);
      }
    });
  }

  void updateOrderDetails(
      ClientOrderRequest request, OrderDetailsScreenState screenState) {
    _stateSubject.add(OrderDetailsLoadingState(screenState));
    newActionSubscription?.cancel();
    _ordersService.updateClientOrder(request).then((MyOrderState value) {
      if (value.hasError) {
        screenState.updateMessage(
            false, value.error ?? S.current.errorHappened);
      } else {
        getOrderDetails(request.orderNumber!, screenState);
        screenState.updateMessage(true);
      }
    });
  }

  void initListening(OrderDetailsScreenState screenState, int id) {
    newActionSubscription =
        _fireStoreHelper.onInsertChangeWatcher()?.listen((event) {
      _ordersService.getOrdersDetails(id).then((value) {
        if (value.hasError) {
          _stateSubject.add(OrderDetailsErrorState(
              screenState, value.error ?? S.current.errorHappened, id));
        } else if (value.isEmpty) {
          _stateSubject.add(
              OrderDetailsEmptyState(screenState, S.current.homeDataEmpty, id));
        } else {
          _stateSubject.add(OrderDetailsLoadedState(screenState, value.data));
        }
      });
    });
  }
}

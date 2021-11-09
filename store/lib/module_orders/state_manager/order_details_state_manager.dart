import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_details_model.dart';
import 'package:mandob_moshtarayat/module_orders/service/orders_service.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_details_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/order_details_loaded_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/order_details_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/orders_details_empty_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/orders_details_error_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/orders_details_loading_state.dart';

@injectable
class OrderDetailsStateManager {
  final OrdersService _ordersService;
  final PublishSubject<OrderDetailsState> _stateSubject = PublishSubject();

  Stream<OrderDetailsState> get stateStream => _stateSubject.stream;

  OrderDetailsStateManager(this._ordersService);

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
        OrderDetailsModel model = value as OrderDetailsModel;
        _stateSubject.add(OrderDetailsLoadedState(screenState, model.data));
      }
    });
  }
}

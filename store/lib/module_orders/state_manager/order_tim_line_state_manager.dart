import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_time_line_model.dart';
import 'package:mandob_moshtarayat/module_orders/service/orders_service.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_timeline_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_timeline/order_time_line_state.dart';

@injectable
class OrderTimeLineStateManager {
  final OrdersService _ordersService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderTimeLineStateManager(this._ordersService);

  StreamSubscription? newActionSubscription;

  void getOrderTimeLine(int id, OrderTimLineScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.getOrderTimeLine(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(OrderTimLineLoadedState(screenState,null,error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(OrderTimLineLoadedState(screenState,null,empty: value.isEmpty));
      } else {
        OrderTimeLineModel model = value as OrderTimeLineModel;
        _stateSubject.add(OrderTimLineLoadedState(screenState,model));
      }
    });
  }
}

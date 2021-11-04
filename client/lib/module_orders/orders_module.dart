import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/client_order_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/my_orders_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_details_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_logs_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_status_screen.dart';

@injectable
class OrdersModule extends YesModule {
  final MyOrdersScreen _myOrdersScreen;
  final OrderDetailsScreen _orderDetailsScreen;
  final OrderStatusScreen _orderStatusScreen;
  final ClientOrderScreen _clientOrderScreen;
  final OrderLogsScreen _orderLogsScreen;
  OrdersModule(this._myOrdersScreen, this._orderDetailsScreen,
      this._orderStatusScreen, this._clientOrderScreen, this._orderLogsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.MY_ORDERS: (context) => _myOrdersScreen,
      OrdersRoutes.ORDER_DETAILS: (context) => _orderDetailsScreen,
      OrdersRoutes.ORDER_STATUS: (context) => _orderStatusScreen,
      OrdersRoutes.CLIENT_ORDER: (context) => _clientOrderScreen,
      OrdersRoutes.ORDER_LOG: (context) => _orderLogsScreen,
    };
  }
}

import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_status_screen.dart';

abstract class OrderStatusState {
  final OrderStatusScreenState orderStatusScreenState;

  OrderStatusState(this.orderStatusScreenState);

  Widget getUI(BuildContext context);
}

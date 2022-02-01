import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_logs_screen.dart';

abstract class OrderLogsState {
  final OrderLogsScreenState orderLogsScreenState;

  OrderLogsState(this.orderLogsScreenState);

  Widget getUI(BuildContext context);
}

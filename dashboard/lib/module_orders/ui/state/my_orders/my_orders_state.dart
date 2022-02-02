import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/screen/my_orders_screen.dart';

abstract class MyOrdersState {
  final OrdersScreenState myOrdersScreenState;

  MyOrdersState(this.myOrdersScreenState);

  Widget getUI(BuildContext context);
}

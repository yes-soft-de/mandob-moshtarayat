import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/screens/order_status/order_status_screen.dart';

abstract class OrderDetailsState {
  final OrderStatusScreenState orderStatusScreenState;

  OrderDetailsState(this.orderStatusScreenState);

  Widget getUI(BuildContext context);
}

class OrderDetailsStateInit extends OrderDetailsState {
  OrderDetailsStateInit(OrderStatusScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

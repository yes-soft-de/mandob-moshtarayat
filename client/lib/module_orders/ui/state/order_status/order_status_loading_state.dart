import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_status_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_status/order_status_state.dart';

class OrderStatusLoadingState extends OrderStatusState {
  OrderStatusLoadingState(OrderStatusScreenState screenState)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

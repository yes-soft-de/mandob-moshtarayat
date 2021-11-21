import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/order_status/order_status.state.dart';

class OrderDetailsStateLoading extends OrderDetailsState {
  OrderDetailsStateLoading(OrderStatusScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

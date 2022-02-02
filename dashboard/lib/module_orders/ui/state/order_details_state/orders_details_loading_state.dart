import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/screen/order_details_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/state/order_details_state/order_details_state.dart';

class OrderDetailsLoadingState extends OrderDetailsState {
  OrderDetailsLoadingState(OrderDetailsScreenState screenState)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

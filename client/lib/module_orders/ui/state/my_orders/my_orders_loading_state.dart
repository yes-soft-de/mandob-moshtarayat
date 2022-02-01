import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/my_orders_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/my_orders/my_orders_state.dart';

class MyOrdersLoadingState extends MyOrdersState {
  MyOrdersLoadingState(MyOrdersScreenState screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

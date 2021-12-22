import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'captain_orders_list_state.dart';

class CaptainOrdersListStateUnauthorized extends CaptainOrdersListState {
  CaptainOrdersListStateUnauthorized(CaptainOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    screenState.requestAuthorization();
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

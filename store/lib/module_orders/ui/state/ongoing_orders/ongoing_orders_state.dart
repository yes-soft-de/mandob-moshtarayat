import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/OngoingOrdersScreen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/my_orders_screen.dart';

abstract class OngoingState {
  final OnGoingOrdersScreenState onGoingOrdersScreenState;

  OngoingState(this.onGoingOrdersScreenState);

  Widget getUI(BuildContext context);
}

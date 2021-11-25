import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/OngoingOrdersScreen.dart';

import 'ongoing_orders_state.dart';

class OnGoingOrdersLoadingState extends OngoingState {
  OnGoingOrdersLoadingState(OnGoingOrdersScreenState screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
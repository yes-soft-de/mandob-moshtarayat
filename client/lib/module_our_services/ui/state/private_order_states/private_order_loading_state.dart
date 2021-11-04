import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/screen/private_order_screen.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/screen/send_it_screen.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/private_order_states/private_order_state.dart';

class PrivateOrderLoadingState extends PrivateOrderState {
  PrivateOrderLoadingState(PrivateOrderScreenState screenState)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

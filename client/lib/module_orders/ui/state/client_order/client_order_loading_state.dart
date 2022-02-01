import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/client_order_screen.dart';
import 'client_order_state.dart';

class ClientLoadingState extends ClientOrderState {
  ClientLoadingState(ClientOrderScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

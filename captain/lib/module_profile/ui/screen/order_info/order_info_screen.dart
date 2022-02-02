import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_profile/state_manager/order/order_info_state_manager.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/states/order_details_state/order_details_state.dart';

@injectable
class OrderInfoScreen extends StatefulWidget {
  final OrderInfoStateManager _orderInfoStateManager;
  @override
  OrderInfoScreenState createState() => OrderInfoScreenState();
  OrderInfoScreen(this._orderInfoStateManager);
}

class OrderInfoScreenState extends State<OrderInfoScreen> {
  OrderInfoState? currentState;
  StreamSubscription? orderDetailsStream;
  int orderId = 0;
  @override
  void initState() {
    super.initState();
    orderDetailsStream =
        widget._orderInfoStateManager.stateStream.listen((event) {
      currentState = event;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentState == null) {
      orderId = ModalRoute.of(context)!.settings.arguments! as int;
      widget._orderInfoStateManager.getOrderdetails(this, orderId);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).orderDetails,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: currentState?.getUI(context) ??
          OrderInfoStateLoading(this).getUI(context),
    );
  }

  @override
  void dispose() {
    if (orderDetailsStream != null) {
      orderDetailsStream?.cancel();
    }
    super.dispose();
  }
}

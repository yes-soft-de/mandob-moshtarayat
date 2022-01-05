import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/module_orders/state_manager/order_details_state_manager.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/order_details_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/orders_details_loading_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/order_details/custom_alert_dialog.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class OrderDetailsScreen extends StatefulWidget {
  final OrderDetailsStateManager _stateManager;

  const OrderDetailsScreen(this._stateManager);

  @override
  OrderDetailsScreenState createState() => OrderDetailsScreenState();
}

class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late OrderDetailsState currentState;
  ClientOrderRequest? clientOrderRequest;
  late StreamSubscription stateSub;
  bool flagOrderId = true;
  int? orderNumber;
  bool edit = false;
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void deleteMessage(bool success, [String err = '']) {
    if (success) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          MainRoutes.MAIN_SCREEN, (route) => false,
          arguments: 1);
      CustomFlushBarHelper.createSuccess(
        title: S.of(context).warnning,
        message: S.of(context).deleteSuccess,
      ).show(context);
    } else {
      Navigator.of(context).pop();
      CustomFlushBarHelper.createError(
              title: S.of(context).warnning, message: err)
          .show(context);
    }
  }

  void updateMessage(bool success, [String err = '']) {
    if (success) {
      CustomFlushBarHelper.createSuccess(
        title: S.of(context).warnning,
        message: S.of(context).updateOrderSuccess,
      ).show(context);
    } else {
      Navigator.of(context).pop();
      CustomFlushBarHelper.createError(
              title: S.of(context).warnning, message: err)
          .show(context);
    }
  }

  // methods
  void deleteOrder(int id) {
    showDialog(
        context: context,
        builder: (_) {
          return CustomAlertDialog(
            onPressed: () {
              Navigator.of(context).pop();
              widget._stateManager.deleteOrderDetails(id, this);
            },
          );
        });
  }

  void updateClientOrder() {
    widget._stateManager.updateOrderDetails(clientOrderRequest!, this);
  }

  void getOrderDetails(int id) {
    widget._stateManager.getOrderDetails(id, this);
  }

  @override
  void initState() {
    super.initState();
    currentState = OrderDetailsLoadingState(this);
    stateSub = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    Hive.box('Order').listenable(keys: ['cart']).addListener(() {
      if (CartHiveHelper().getProduct() != null) {
        clientOrderRequest?.products = CartHiveHelper().getProduct();
        CartHiveHelper().setFinish();
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (flagOrderId && args is String) {
      widget._stateManager.getOrderDetails(int.parse(args), this);
      orderNumber = int.parse(args);
      flagOrderId = false;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body: FixedContainer(child: currentState.getUI(context)),
      ),
    );
  }

  @override
  void dispose() {
    widget._stateManager.newActionSubscription?.cancel();
    Hive.box('Order').listenable(keys: ['cart']).removeListener(() {});
    stateSub.cancel();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/state_manager/order_tim_line_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/state/my_orders/my_orders_loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class OrderTimLineScreen extends StatefulWidget {
  final OrderTimeLineStateManager _stateManager;

  OrderTimLineScreen(this._stateManager);

  @override
  OrderTimLineScreenState createState() => OrderTimLineScreenState();
}

class OrderTimLineScreenState extends State<OrderTimLineScreen> {
  late States currentState;
  void getOrder() {
    widget._stateManager.getOrderTimeLine(orderId ?? -1, this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    currentState = MyOrdersLoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  int? orderId;
  bool flagArgs = true;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flagArgs) {
      orderId = int.parse(args.toString());
      flagArgs = false;
      widget._stateManager.getOrderTimeLine(orderId ?? -1, this);
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomTwaslnaAppBar.appBar(context,
            title: S.of(context).orderStatus),
        body: currentState.getUI(context),
      ),
    );
  }

  @override
  void dispose() {
    widget._stateManager.newActionSubscription?.cancel();
    super.dispose();
  }
}

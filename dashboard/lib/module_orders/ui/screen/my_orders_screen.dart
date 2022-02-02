import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/state_manager/my_orders_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/state/my_orders/my_orders_loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/state/my_orders/my_orders_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

@injectable
class OrdersScreen extends StatefulWidget {
  final MyOrdersStateManager _stateManager;

  OrdersScreen(this._stateManager);

  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  late States currentState;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getOrders() async {
    widget._stateManager.getOrders(this);
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: 1);
    CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.pleaseLoginToContinue)
        .show(context);
  }

  @override
  void initState() {
    currentState = MyOrdersLoadingState(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget._stateManager.getOrders(this);
    });
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomMandoobAppBar.appBar(context,
            title: S.of(context).orderPending, icon: Icons.menu, onTap: () {
          GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
        }),
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

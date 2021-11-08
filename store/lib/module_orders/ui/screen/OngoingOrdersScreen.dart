import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/global_nav_key.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_main/ui/screen/main_screen.dart';
import 'package:mandob_moshtarayat/module_orders/state_manager/ongoing_orders_state_manager.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/my_orders/my_orders_loading_state.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class OnGoingOrdersScreen extends StatefulWidget {
  final OnGoingOrdersStateManager _stateManager;

  OnGoingOrdersScreen(this._stateManager);

  @override
  OnGoingOrdersScreenState createState() => OnGoingOrdersScreenState();
}

class OnGoingOrdersScreenState extends State<OnGoingOrdersScreen> {
  late States currentState;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
  Future <void> getOrders() async {
    widget._stateManager.getOrders(this);
  }
  void goToLogin(){
    Navigator.of(context).pushNamed(AuthorizationRoutes.LOGIN_SCREEN,arguments:1);
    CustomFlushBarHelper.createError(title:S.current.warnning, message:S.current.pleaseLoginToContinue).show(context);
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
        appBar: CustomTwaslnaAppBar.appBar(context,
            title: S.of(context).ongoingOrders, icon: Icons.menu, onTap: () {
             MainScreenState.advancedController.showDrawer();
            }),
        body: currentState.getUI(context),
      ),
    );
  }

  @override
  void dispose(){
    widget._stateManager.newActionSubscription?.cancel();
    super.dispose();
  }
}

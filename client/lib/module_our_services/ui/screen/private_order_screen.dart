import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/module_our_services/request/private_order_request.dart';
import 'package:mandob_moshtarayat/module_our_services/state_manager/private_order_state_manager.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/private_order_states/private_order_Loaded_state.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/private_order_states/private_order_state.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class PrivateOrderScreen extends StatefulWidget {
  final PrivateOrderStateManager _stateManager;

  PrivateOrderScreen(this._stateManager);

  @override
  PrivateOrderScreenState createState() => PrivateOrderScreenState();
}

class PrivateOrderScreenState extends State<PrivateOrderScreen> {
  late PrivateOrderState currentState;
  late PrivateOrderRequest request;
  AsyncSnapshot myLocation = AsyncSnapshot.nothing();

  @override
  void initState() {
    super.initState();
    currentState = PrivateOrderLoadedState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void getLocation() {
    widget._stateManager.getLocation(this);
  }

  void postPrivateOrder() {
    widget._stateManager.postPrivateOrder(request, this);
  }

  void moveDecision(bool success, [String err = '']) {
    if (success) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
      CustomFlushBarHelper.createSuccess(
        title: S.of(context).warnning,
        message: S.of(context).successCreateOrder,
      )..show(context);
    } else {
      Navigator.of(context).pop();
      CustomFlushBarHelper.createError(
          title: S.of(context).warnning, message: err)
        ..show(context);
    }
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: true);
    CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: S.current.pleaseLoginToMakeOrder)
        .show(context);
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
        body: currentState.getUI(context),
      ),
    );
  }
}

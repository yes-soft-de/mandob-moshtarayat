import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/di/di_config.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat_captain/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:mandob_moshtarayat_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_captain/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:mandob_moshtarayat_captain/module_auth/ui/states/login_states/login_state.dart';
import 'package:mandob_moshtarayat_captain/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat_captain/module_splash/splash_routes.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/custom_flushbar.dart';

@injectable
class LoginScreen extends StatefulWidget {
  final LoginStateManager _stateManager;

  LoginScreen(this._stateManager);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late LoginState _currentStates;
  late AsyncSnapshot loadingSnapshot;
  late StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadingSnapshot = AsyncSnapshot.nothing();
    _currentStates = LoginStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentStates = event;
        });
      }
    });
    widget._stateManager.loadingStream.listen((event) {
      if (this.mounted) {
        setState(() {
          loadingSnapshot = event;
        });
      }
    });
  }

  dynamic args;

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
            title: S.of(context).login, canGoBack: false),
        body: loadingSnapshot.connectionState != ConnectionState.waiting
            ? _currentStates.getUI(context)
            : Stack(
                children: [
                  _currentStates.getUI(context),
                  Container(
                    width: double.maxFinite,
                    color: Colors.transparent.withOpacity(0.0),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  void loginClient(String email, String password) {
    widget._stateManager.loginClient(email, password, this);
  }

  void moveToNext() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (route) => false);

    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.loginSuccess)
        .show(context);
  }
    void verifyFirst(String? userID, String? password) {
    if (userID == null || password == null) {
      getIt<AuthService>().logout();
      Navigator.pushNamedAndRemoveUntil(
          context, SplashRoutes.SPLASH_SCREEN, (route) => false);
      return;
    }
    Navigator.of(context).pushNamed(
        AuthorizationRoutes.REGISTER_SCREEN,
        arguments: {"userID": userID, "pass": password});
    CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.confirmCode)
        .show(context);
  }
   void restPass(ResetPassRequest request) {
    widget._stateManager.resetCodeRequest(request, this);
  }

  void moveToForgetPage() {
    Navigator.of(context).pushNamed(AuthorizationRoutes.ForgotPass_SCREEN);
  }
}

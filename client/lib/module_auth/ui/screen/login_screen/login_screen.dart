import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/favourite_screen.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_auth/presistance/auth_prefs_helper.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/login_states/login_state.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/module_splash/splash_routes.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

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

  int? returnToMainScreen;
  bool? returnToPreviousScreen;
  @override
  void initState() {
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
    super.initState();
  }

  dynamic args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      if (args is bool) returnToPreviousScreen = args;
      if (args is int) returnToMainScreen = args;
    }
    return WillPopScope(
      onWillPop: () async {
        await Navigator.of(context)
            .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
        return returnToMainScreen == null;
      },
      child: GestureDetector(
        onTap: () {
          var focus = FocusScope.of(context);
          if (focus.canRequestFocus) {
            focus.unfocus();
          }
        },
        child: Scaffold(
          appBar: CustomTwaslnaAppBar.appBar(context,
              title: S.of(context).login,
              onTap: returnToMainScreen != null
                  ? () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          MainRoutes.MAIN_SCREEN, (route) => false);
                    }
                  : null),
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
    if (returnToMainScreen != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false,
              arguments: returnToMainScreen)
          .then((value) {
        if (returnToMainScreen == 0) {
          showDialog(
              context: context, builder: (context) => getIt<FavouritScreen>());
        }
      });
    } else if (returnToPreviousScreen != null) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
    }
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
    Navigator.of(context).pushNamedAndRemoveUntil(
        AuthorizationRoutes.REGISTER_SCREEN, (route) => false,
        arguments: {"userID": userID, "pass": password});
    CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.confirmCode)
        .show(context);
  }
}

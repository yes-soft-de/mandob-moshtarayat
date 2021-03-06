import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/account_routes.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/favourite_screen.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/register_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/verfy_code_request.dart';
import 'package:mandob_moshtarayat/module_auth/state_manager/register_state_manager/register_state_manager.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/register_states/register_state.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/register_states/register_state_code_sent.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class RegisterScreen extends StatefulWidget {
  final RegisterStateManager _stateManager;

  RegisterScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  late RegisterState _currentState;
  late AsyncSnapshot loadingSnapshot;
  late StreamSubscription _stateSubscription;
  int? returnToMainScreen;
  bool? returnToPreviousScreen;
  late bool flags = true;
  bool activeResend = false;
  @override
  void initState() {
    super.initState();
    loadingSnapshot = AsyncSnapshot.nothing();
    _currentState = RegisterStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (this.mounted) {
        setState(() {
          _currentState = event;
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
    args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      if (args is bool) returnToPreviousScreen = args;
      if (args is int) returnToMainScreen = args;
      if (args is Map) {
        _currentState = RegisterStatePhoneCodeSent(this);
      }
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
              title: S.of(context).register,
              onTap: returnToMainScreen != null
                  ? () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          MainRoutes.MAIN_SCREEN, (route) => false);
                    }
                  : null),
          body: FixedContainer(
            child: loadingSnapshot.connectionState != ConnectionState.waiting
                ? _currentState.getUI(context)
                : Stack(
                    children: [
                      _currentState.getUI(context),
                      Container(
                        width: double.maxFinite,
                        color: Colors.transparent.withOpacity(0.0),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void registerClient(RegisterRequest request) {
    widget._stateManager.registerClient(request, this);
  }

  void verifyClient(VerifyCodeRequest request) {
    widget._stateManager.verifyClient(request, this);
  }

  void resendCode(VerifyCodeRequest request) {
    widget._stateManager.resendCode(request, this);
  }

  void resentCodeSucc() {
    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.resendCodeSuccessfully)
        .show(context);
  }

  void wrongCode() {
    CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.invalidCode)
        .show(context);
  }

  void resendError() {
    CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.errorHappened)
        .show(context);
  }

  void verifyFirst() {
    CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.notVerifiedNumber)
        .show(context);
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

  Future<void> userRegistered() async {
    await CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.registerSuccess,
            timeout: 2)
        .show(context);
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }
}

import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/reset_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/login_states/login_state.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_init/init_routes.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/module_auth/request/register_request/verify_code_request.dart';

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

  late String userID;
  late String pass;

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
  bool canBack = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args ==1) {
      canBack = true;
    }
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
        resizeToAvoidBottomInset: false,
        appBar: CustomMandopAppBar.appBar(context,
            title: S.of(context).login, canGoBack: canBack),

        body: loadingSnapshot.connectionState != ConnectionState.waiting
            ? FixedContainer(child: _currentStates.getUI(context))
            : Stack(
                children: [
                  FixedContainer(child: _currentStates.getUI(context)),
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
    userID = email;
    pass=password;
    widget._stateManager.loginClient(email, password, this);
  }
//
//  void verifyClient(VerifyCodeRequest request) {
//    widget._stateManager.verifyClient(request, this);
//  }
//  void resendCode(VerifyCodeRequest request) {
//    widget._stateManager.resendCode(request, this);
//  }
  void moveToNext() {
    Navigator.of(context).pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);

    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.loginSuccess)
        .show(context);
  }
  void moveToProfileInit(String userID) {
    Navigator.of(context).pushNamedAndRemoveUntil(InitAccountRoutes.INIT_ACCOUNT_SCREEN, (route) => false,arguments: userID);
    CustomFlushBarHelper.createError(
        title: S.current.warnning, message: S.current.profileIncomplete)
        .show(context);
  }
  void verifyFirst() {
    print('fofof');
    Navigator.of(context).pushNamedAndRemoveUntil(AuthorizationRoutes.REGISTER_SCREEN, (route) => false,arguments: {"userID":userID ,"pass":pass});
    CustomFlushBarHelper.createError(
        title: S.current.error, message: S.current.confirmCode)
        .show(context);
  }
  void restPass(ResetPassRequest request) {
    widget._stateManager.resetCodeRequest(request,this);
  }
  void moveToForgetPage(){
 Navigator.of(context).pushNamed(AuthorizationRoutes.ForgotPass_SCREEN,arguments: userID);

  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/update_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/verify_code_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/state_manager/forgot_pass_state_manager/forgot_state_manager.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/forgot_pass_states/forgot_state.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/forgot_pass_states/forgot_state_code_sent.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class ForgotPassScreen extends StatefulWidget {
  final ForgotPassStateManager _stateManager;

  ForgotPassScreen(this._stateManager);

  @override
  ForgotPassScreenState createState() => ForgotPassScreenState();
}

class ForgotPassScreenState extends State<ForgotPassScreen> {
  late ForgotPassState _currentStates;
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
    _currentStates = ForgotStatePhoneCodeSent(this);
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      userID = args;
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
            title: S.of(context).forgotPass, canGoBack: true),

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
  void moveToLogin() {
       Navigator.of(context).pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
CustomFlushBarHelper.createSuccess(
        title: S.current.warnning, message: S.current.passwordUpdatedSuccess)
        .show(context);
  }
  void verifyCode(VerifyResetPassCodeRequest request){
    widget._stateManager.verifyResetPassCodeRequest(request, this);
  }
  void updatePassword(UpdatePassRequest request){
    widget._stateManager.updatePassword(request, this);
  }
}
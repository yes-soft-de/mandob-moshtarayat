import 'package:mandob_moshtarayat/consts/country_code.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/order_details/custom_alert_dialog.dart';
import 'package:mandob_moshtarayat/utils/components/auth_buttons.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class LoginStateInit extends LoginState {
  LoginStateInit(LoginScreenState screen, {String? error}) : super(screen) {
    if (error != null) {
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
          .show(screen.context);
    }
  }
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  @override
  Widget getUI(BuildContext context) {
    return Form(
      key: _loginKey,
      child: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 32.0, top: 16),
                      child: Image.asset(
                        ImageAsset.LOGO,
                        width: 150,
                        height: 150,
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 85, right: 85, top: 8),
                child: Text(
                  S.of(context).phoneNumber,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.phone),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                      sufIcon: const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(CountryCode.COUNTRY_CODE_KSA),
                      ),
                      controller: usernameController,
                      phone: true,
                      contentPadding:
                          const EdgeInsets.only(top: 15, right: 8.0, left: 8.0),
                      hintText: '5xxxxxxxx'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 85, right: 85, top: 8),
                child: Text(
                  S.of(context).password,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.lock),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    last: true,
                    controller: passwordController,
                    password: true,
                    contentPadding: const EdgeInsets.fromLTRB(16, 13, 16, 0),
                    hintText: S.of(context).password,
                  ),
                ),
              ),
              Container(
                height: 16,
              ),
              InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (usernameController.text.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return CustomAlertDialog(
                                message: S.of(context).informSendCode,
                                onPressed: () {
                                  Navigator.pop(context);
                                  screen.restPass(ResetPassRequest(
                                      userID: usernameController.text));
                                });
                          });
                    } else {
                      CustomFlushBarHelper.createError(
                              title: S.current.warnning,
                              message: S.current.pleaseInputPhoneNumber)
                          .show(context);
                    }
                  },
                  child: Center(
                      child: Text(
                    S.of(context).forgotPass,
                    style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.bold),
                  ))),
              Container(
                height: 150,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AuthButtons(
                firstButtonTitle: S.of(context).login,
                secondButtonTitle: S.of(context).register,
                loading: screen.loadingSnapshot.connectionState ==
                    ConnectionState.waiting,
                secondButtonTab: () => Navigator.of(context)
                    .pushReplacementNamed(AuthorizationRoutes.REGISTER_SCREEN,
                        arguments: screen.args),
                firstButtonTab: () {
                  if (_loginKey.currentState!.validate()) {
                    screen.loginClient(
                        usernameController.text, passwordController.text);
                  }
                }),
          ),
        ],
      ),
    );
  }
}

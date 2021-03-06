import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat_captain/consts/country_code.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat_captain/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:mandob_moshtarayat_captain/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:mandob_moshtarayat_captain/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:mandob_moshtarayat_captain/utils/components/auth_buttons.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_alert_dialog.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat_captain/utils/images/images.dart';

class LoginStateInit extends LoginState {
  LoginStateInit(LoginScreenState screen, {String? error}) : super(screen) {
    if (error != null) {
      CustomFlushBarHelper.createError(
          title: S.current.warnning, message: error)
        ..show(screen.context);
    }
  }
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  TextStyle tileStyle = TextStyle(fontWeight: FontWeight.w600);
  @override
  Widget getUI(BuildContext context) {
    return Form(
      key: _loginKey,
      child: Stack(
        children: [
          ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? SvgPicture.asset(
                      SvgAsset.WE_DELIVER,
                      width: 150,
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 4.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).phoneNumber,
                  style: tileStyle,
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    contentPadding:
                        EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 0),
                    controller: usernameController,
                    hintText: '5xxxxxxx',
                    phone: true,
                    sufIcon: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(CountryCode.COUNTRY_CODE_KSA),
                    ),
                    preIcon: Icon(Icons.email),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).password,
                  style: tileStyle,
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    preIcon: Icon(Icons.lock),
                    last: true,
                    controller: passwordController,
                    password: true,
                    contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    hintText: S.of(context).password,
                  ),
                ),
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

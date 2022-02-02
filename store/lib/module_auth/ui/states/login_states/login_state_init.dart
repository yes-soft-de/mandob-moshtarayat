import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/consts/country_code.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_auth/request/forgot_pass_request/reset_pass_request.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:mandob_moshtarayat/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:mandob_moshtarayat/utils/components/auth_buttons.dart';
import 'package:mandob_moshtarayat/utils/components/custom_alert_dialog.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

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
  final GlobalKey<FormFieldState> _phoneKey = GlobalKey<FormFieldState>();
  AutovalidateMode mode = AutovalidateMode.disabled;
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
              Container(height: 50,),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Image.asset(
                      ImageAsset.LOGO,
                      height: 250,
                      width: 150,
                    )
                  : Container(),

              Padding(
                padding: const EdgeInsets.only(
                    bottom: 4.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).phone,
                  style: tileStyle,
                ),
              ),
//              ListTile(
//                title: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: CustomLoginFormField(
//                    contentPadding:EdgeInsets.only(left: 0,right: 0,top: 15,bottom: 0),
//                    controller: usernameController,
//                    hintText: S.of(context).registerHint,
//                    preIcon: Icon(Icons.email),
//                  ),
//                ),
//              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      key: _phoneKey,
                      autovalidateMode: mode,
                      toolbarOptions: ToolbarOptions(
                          copy: true, paste: true, selectAll: true, cut: true),
                      controller: usernameController,
                      keyboardType: TextInputType.phone,
                      maxLength: 9,
                      validator: (value){
                        if (mode == AutovalidateMode.disabled) {
                          mode = AutovalidateMode.onUserInteraction;
                          screen.refresh();
                        }
                        if (value == null) {
                          return S.of(context).pleaseCompleteField;
                        }else if (value.length <9){
                          return S.of(context).invalidNumber;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(context).phone,
                        prefixIcon:Icon(Icons.phone) ,
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        prefix: Text(CountryCode.COUNTRY_CODE),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
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
                    preIcon:Icon(Icons.lock),
                    last: true,
                    controller: passwordController,
                    password: true,
                    contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    hintText: S.of(context).password,
                  ),
                ),
              ),
              Container(
                height: 10,
              ),
              InkWell(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    if(_phoneKey.currentState!.validate())
                    showDialog(
                        context: context,
                        builder: (_) {
                          return CustomAlertDialog(
                            message: S.of(context).informSendCode,
                              onPressed: () {
                                Navigator.pop(context);
                              screen.userID = usernameController.text;
                              screen.restPass(ResetPassRequest(userID:usernameController.text ));

                              });
                        });
                  },
                  child: Center(child: Text(S.of(context).forgotPass, style: StyleText.textsAlmaraiNormal,))),
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
                    screen.userID = usernameController.text.trim();
                    screen.pass = passwordController.text.trim();
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

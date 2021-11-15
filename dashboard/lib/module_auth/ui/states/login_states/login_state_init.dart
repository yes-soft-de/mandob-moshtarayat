import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/auth_buttons.dart';
import 'package:mandob_moshtarayat_dashboad/utils/global/screen_type.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/images/images.dart';

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
          Container(
            width: double.maxFinite,
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    MediaQuery.of(context).viewInsets.bottom == 0
                        ? SvgPicture.asset(
                            SvgAsset.AUTH_SVG,
                            width: 150,
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 4.0, left: 32, right: 32, top: 8),
                      child: Text(
                        S.of(context).username,
                        style: tileStyle,
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomLoginFormField(
                          contentPadding: EdgeInsets.only(
                              left: 0, right: 0, top: 15, bottom: 0),
                          controller: usernameController,
                          hintText: S.of(context).registerHint,
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
                    Container(
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: BoxConstraints(maxWidth: 600),
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
          ),
        ],
      ),
    );
  }
}

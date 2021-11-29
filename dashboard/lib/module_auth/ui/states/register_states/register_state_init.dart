import 'package:flutter_svg/svg.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/request/register_request/register_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/ui/states/register_states/register_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/auth_buttons.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/images/images.dart';

class RegisterStateInit extends RegisterState {
  RegisterStateInit(RegisterScreenState screen,
      {String? error, bool registered = false})
      : super(screen) {
    if (error != null) {
      if (registered) {
        screen.userRegistered().whenComplete(() {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: error)
            ..show(screen.context);
        });
      } else {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: error)
          ..show(screen.context);
      }
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  bool agreed = false;
  TextStyle tileStyle = TextStyle(fontWeight: FontWeight.w600);

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _registerKey,
          child: Container(
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
                            SvgAsset.EMAIL,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CheckboxListTile(
                          value: agreed,
                          title: Text(S
                              .of(context)
                              .iAgreeToTheTermsOfServicePrivacyPolicy),
                          onChanged: (v) {
                            agreed = v ?? false;
                            screen.refresh();
                          }),
                    ),
                    Container(
                      height: 175,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: AuthButtons(
              firstButtonTitle: S.of(context).register,
              secondButtonTitle: S.of(context).iHaveAnAccount,
              loading: screen.loadingSnapshot.connectionState ==
                  ConnectionState.waiting,
              secondButtonTab: () => Navigator.of(context).pushReplacementNamed(
                  AuthorizationRoutes.LOGIN_SCREEN,
                  arguments: screen.args),
              firstButtonTab: agreed
                  ? () {
                      if (_registerKey.currentState!.validate()) {
                        screen.registerClient(RegisterRequest(
                            userID: usernameController.text,
                            password: passwordController.text,
                            userName: nameController.text));
                      }
                    }
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

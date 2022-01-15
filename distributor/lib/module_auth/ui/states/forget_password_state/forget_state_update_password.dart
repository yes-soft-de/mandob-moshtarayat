import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart';
import 'package:mandob_moshtarayat/module_auth/ui/widget/login_widgets/custom_field.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class ForgotStateUpdatePassword extends States {
  ForgotPassScreenState screenState;
  ForgotStateUpdatePassword(this.screenState) : super(screenState);

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _verifyKey = GlobalKey<FormState>();
  TextStyle tileStyle = const TextStyle(fontWeight: FontWeight.w600);

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _verifyKey,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                height: 50,
              ),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Image.asset(
                      ImageAsset.LOGO,
                      height: 250,
                      width: 150,
                    )
                  : Container(),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).newPassword,
                  style: tileStyle,
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    preIcon: const Icon(Icons.lock),
                    last: false,
                    controller: passwordController,
                    password: true,
                    contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    hintText: S.of(context).newPassword,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, left: 32, right: 32, top: 8),
                child: Text(
                  S.of(context).confirmNewPass,
                  style: tileStyle,
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoginFormField(
                    preIcon: const Icon(Icons.lock),
                    last: true,
                    controller: confirmPasswordController,
                    password: true,
                    contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    hintText: S.of(context).confirmNewPass,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16, bottom: 8.0, top: 8.0),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_verifyKey.currentState!.validate() &&
                            passwordController.text ==
                                confirmPasswordController.text) {
                          screenState.updatePassword(UpdatePassRequest(
                              userID: getIt<AuthService>().username,
                              newPassword: passwordController.text));
                        } else {
                          CustomFlushBarHelper.createError(
                                  title: S.current.warnning,
                                  message: S.current.passwordNotMatch)
                              .show(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).accentColor,
                        textStyle: const TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: screenState.loadingSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                S.of(context).update,
                                style: const TextStyle(color: Colors.white),
                              ),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

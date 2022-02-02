import 'package:mandob_moshtarayat_dashboad/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

abstract class LoginState {
  final LoginScreenState screen;
  LoginState(this.screen);

  Widget getUI(BuildContext context);
}

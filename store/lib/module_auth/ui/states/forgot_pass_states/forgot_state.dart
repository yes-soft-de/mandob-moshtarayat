import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_auth/ui/screen/forgot_pass_screen/forgot_pass_screen.dart';

abstract class ForgotPassState {
  final ForgotPassScreenState screen;
  ForgotPassState(this.screen);

  Widget getUI(BuildContext context);
}

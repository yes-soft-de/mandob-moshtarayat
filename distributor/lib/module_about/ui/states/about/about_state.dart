import 'package:mandob_moshtarayat/module_about/state_manager/about_screen_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_about/ui/screen/about_screen/about_screen.dart';

abstract class AboutState {
  AboutScreenState screenState;
  AboutState(this.screenState);

  Widget getUI(BuildContext context);
}
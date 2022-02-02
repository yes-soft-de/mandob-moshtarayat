import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/screen/activity_screen/activity_screen.dart';

abstract class ActivityState {
  final ActivityScreenState screen;
  ActivityState(this.screen);

  Widget getUI(BuildContext context);
}

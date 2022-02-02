import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/stores_screen.dart';

abstract class StoresState {
  final StoresScreenState homeScreenState;
  StoresState(this.homeScreenState);
  Widget getUI(BuildContext context);
}

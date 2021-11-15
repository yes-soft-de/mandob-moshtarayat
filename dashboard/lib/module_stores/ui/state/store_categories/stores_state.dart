import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/stores_screen.dart';

abstract class StoresState {
  final StoresScreenState state;

  StoresState(this.state);
  Widget getUI(BuildContext context);
}

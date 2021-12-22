import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/module_plan/ui/screen/plan_screen.dart';

abstract class PlanState {
  final PlanScreenState planScreenState;
  PlanState(this.planScreenState);

  Widget getUI(BuildContext context);
}

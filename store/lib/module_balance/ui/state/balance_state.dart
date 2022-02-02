import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_balance/ui/screen/balance_info_screen.dart';

abstract class BalanceState {
  final BalanceScreenState state;

  BalanceState(this.state);
  Widget getUI(BuildContext context);
}
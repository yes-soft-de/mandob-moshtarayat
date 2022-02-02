import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_balance/ui/screen/balance_info_screen.dart';

import 'balance_state.dart';

class BalanceLoadingState extends BalanceState {
  BalanceLoadingState(BalanceScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

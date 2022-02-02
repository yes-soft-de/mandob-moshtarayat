import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/account_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/account/account_state.dart';

class AccountErrorState extends AccountState {
  final String error;
  AccountScreenState screenState;

  AccountErrorState(this.screenState, this.error) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(child: Text(error));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:mandob_moshtarayat/module_init/ui/state/init_account/init_account.state.dart';

class InitAccountStateFirstLoading extends InitAccountState {
  InitAccountStateFirstLoading(
      InitAccountScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

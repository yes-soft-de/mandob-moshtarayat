import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_account/state_manager/account_state_manager.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/account/account_loading_state.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/account/account_state.dart';

@injectable
class AccountScreen extends StatefulWidget {
  final AccountStateManager _accountStateManager;

  AccountScreen(this._accountStateManager);

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  AccountState? currentState;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    currentState = AccountLoadingState(this);
    widget._accountStateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._accountStateManager.getProfile(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body: currentState?.getUI(context),
      ),
    );
  }
}

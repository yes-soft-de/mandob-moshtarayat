import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:mandob_moshtarayat/module_init/ui/state/init_account/init_account.state.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';

class InitAccountCaptainStateSuccess extends InitAccountState {
  InitAccountCaptainStateSuccess(InitAccountScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.check),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(S.of(context).accountCreated),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                MainRoutes.MAIN_SCREEN, (r) => false);
          },
          child: Text(S.of(context).moveToOrders),
        )
      ],
    );
  }
}

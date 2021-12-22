import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:mandob_moshtarayat_captain/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob_moshtarayat_captain/module_orders/orders_routes.dart';

class InitAccountStateProfileCreated extends InitAccountState {
  InitAccountStateProfileCreated(InitAccountScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Lottie.asset('assets/animations/register-success.json'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    S.of(context).go,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (r) => false);
                }),
          )
        ],
      ),
    );
  }
}

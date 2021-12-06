import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_balance/state_manager/balance_state_manager.dart';
import 'package:mandob_moshtarayat/module_balance/ui/state/balance_loading_state.dart';
import 'package:mandob_moshtarayat/module_balance/ui/state/balance_state.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class BalanceScreen extends StatefulWidget {
  final BalanceStateManager _stateManager;


  BalanceScreen(this._stateManager);

  @override
  BalanceScreenState createState() => BalanceScreenState();
}

class BalanceScreenState extends State<BalanceScreen> {
  late BalanceState currentState;

  void goToLogin(){
    Navigator.of(context).pushReplacementNamed(AuthorizationRoutes.LOGIN_SCREEN,arguments:1);
    CustomFlushBarHelper.createError(title:S.current.warnning, message:S.current.pleaseLoginToContinue).show(context);
  }

  @override
  void initState() {
    currentState = BalanceLoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (this.mounted){
        setState(() {
        });
      }
    });
    super.initState();
    widget._stateManager.getBalanceStore(this);
  }
  void getStoreBalance(){
    widget._stateManager.getBalanceStore(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      CustomMandopAppBar.appBar(context, title: S.current.balanceDetails),
      body: currentState.getUI(context),
    );
  }
}

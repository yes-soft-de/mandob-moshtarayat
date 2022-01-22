import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/request/store_payment_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/state_manager/store_balance_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class StoreBalanceScreen extends StatefulWidget {
  final StoreBalanceStateManager _stateManager;

  StoreBalanceScreen(this._stateManager);

  @override
  StoreBalanceScreenState createState() => StoreBalanceScreenState();
}

class StoreBalanceScreenState extends State<StoreBalanceScreen> {
  late States currentState;
  int storeID = -1;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  void pay(StorePaymentRequest request) {
    widget._stateManager.payForStore(this, request);
  }

  void deletePay(String id) {
    widget._stateManager.deletePayment(this, id);
  }

  void getPayments() {
    widget._stateManager.getBalance(this, storeID);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (storeID == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        storeID = arg;
        widget._stateManager.getBalance(this, storeID);
      }
    }
    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context,
          title: S.of(context).storeBalance),
      body: currentState.getUI(context),
    );
  }
}

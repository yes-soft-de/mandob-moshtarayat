import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/state_manager/payments_list_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/state_manager/payments_to_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class PaymentsListScreen extends StatefulWidget {
  final PaymentsListStateManager _stateManager;

  PaymentsListScreen(this._stateManager);

  @override
  PaymentsListScreenState createState() => PaymentsListScreenState();
}

class PaymentsListScreenState extends State<PaymentsListScreen> {
  late States currentState;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getPayments(this);
    super.initState();
  }

  void getPayments() {}

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context,
          title: S.of(context).paymentsList, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

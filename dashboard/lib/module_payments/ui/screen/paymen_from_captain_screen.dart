import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/state_manager/captain_captains_payment_list_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/state_manager/payments_from_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class PaymentsFromCaptainScreen extends StatefulWidget {
  final PaymentsFromCaptainStateManager _stateManager;

  PaymentsFromCaptainScreen(this._stateManager);

  @override
  PaymentsFromCaptainScreenState createState() =>
      PaymentsFromCaptainScreenState();
}

class PaymentsFromCaptainScreenState extends State<PaymentsFromCaptainScreen> {
  late States currentState;
  int captainId = -1;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  void getPayments() {
    widget._stateManager.getCaptainPaymentsDetails(this, captainId);
  }

  void pay(CaptainPaymentsRequest request) {
    widget._stateManager.makePayments(this, request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (captainId == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        captainId = arg;
        widget._stateManager.getCaptainPaymentsDetails(this, captainId);
      }
    }
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).paymentFromCaptain),
      body: currentState.getUI(context),
    );
  }
}

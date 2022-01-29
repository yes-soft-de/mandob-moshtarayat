import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/distro_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/state_manager/payments_from_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/state_manager/payments_to_distro_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/state_manager/payments_to_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class PaymentsToDistroScreen extends StatefulWidget {
  final PaymentsToDistroStateManager _stateManager;

  PaymentsToDistroScreen(this._stateManager);

  @override
  PaymentsToDistroScreenState createState() => PaymentsToDistroScreenState();
}

class PaymentsToDistroScreenState extends State<PaymentsToDistroScreen> {
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
    widget._stateManager.getDistroPaymentsDetails(this, captainId);
  }

  void pay(DistroPaymentsRequest request) {
    widget._stateManager.makePayments(this, request);
  }

  void deletePay(String id) {
    widget._stateManager.deletePayment(this, id);
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
        widget._stateManager.getDistroPaymentsDetails(this, captainId);
      }
    }
    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context,
          title: S.of(context).paymentToDistro),
      body: currentState.getUI(context),
    );
  }
}

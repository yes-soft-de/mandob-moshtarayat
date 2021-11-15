import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/state_manager/captain_captains_payment_list_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/request/pay_tabs_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/state_manager/payments_from_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/state_manager/payments_from_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class PortalScreen extends StatefulWidget {
  final PortalsStateManager _stateManager;

  PortalScreen(this._stateManager);

  @override
  PortalScreenState createState() => PortalScreenState();
}

class PortalScreenState extends State<PortalScreen> {
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

  void pay(PayTabsRequest request) {
    widget._stateManager.makePayments(this, request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).paymentFromCaptain, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: ElevatedButton(
        onPressed: () {
          pay(PayTabsRequest(
              profileId: '80569',
              tranType: 'sale',
              tranClass: 'ecom',
              cartDescription: 'test api',
              cartId: '1',
              cartCurrency: 'sar',
              cartAmount: 1.0,
              returns: 'none',
              callback: 'none',
              cardDetails: Card_details(cvv: '123', pan: '4111111111111111')));
        },
        child: Text(S.current.pay),
      ),
    );
  }
}

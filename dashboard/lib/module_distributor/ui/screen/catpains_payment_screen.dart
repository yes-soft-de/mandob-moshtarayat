import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/state_manager/captain_captains_payment_list_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class CaptainsPaymentsScreen extends StatefulWidget {
  final CaptainsPaymentsStateManager _stateManager;

  CaptainsPaymentsScreen(this._stateManager);

  @override
  CaptainsPaymentsScreenState createState() => CaptainsPaymentsScreenState();
}

class CaptainsPaymentsScreenState extends State<CaptainsPaymentsScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    // widget._stateManager.getCaptains(this);
    super.initState();
  }

  void getCaptains() {
    //  widget._stateManager.getCaptains(this);
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
          title: S.of(context).captainPayments, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

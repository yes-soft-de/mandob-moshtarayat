import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/state_manager/distro_payment_list_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class DistrosPaymentsScreen extends StatefulWidget {
  final DistrosPaymentsStateManager _stateManager;

  DistrosPaymentsScreen(this._stateManager);

  @override
  DistrosPaymentsScreenState createState() =>DistrosPaymentsScreenState();
}

class DistrosPaymentsScreenState extends State<DistrosPaymentsScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
     widget._stateManager.getDistros(this);
    super.initState();
  }

  void getDistros() {
      widget._stateManager.getDistros(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context,
          title: S.of(context).distroPayments, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

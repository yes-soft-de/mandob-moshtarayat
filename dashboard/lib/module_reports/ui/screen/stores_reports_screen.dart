import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/di/di_config.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/state_manager/stores_report_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/global/global_state_manager.dart';

@injectable
class StoresReportScreen extends StatefulWidget {
  final StoresReportStateManager _stateManager;

  StoresReportScreen(this._stateManager);

  @override
  StoresReportScreenState createState() => StoresReportScreenState();
}

class StoresReportScreenState extends State<StoresReportScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    widget._stateManager.getReports(this);
    getIt<GlobalStateManager>().stateStream.listen((event) {
      getCaptains();
    });
    super.initState();
  }

  void getCaptains() {
    widget._stateManager.getReports(this);
  }

  DateTime? fDate;
  DateTime? lDate;
  void getOrderFilteredDate(DateTime firstDate, DateTime endDate) {
    fDate = firstDate;
    lDate = endDate;
    widget._stateManager.getReportsSpecific(
        this,
        DateFormat('yyyy-MM-dd', 'en').format(firstDate),
        DateFormat('yyyy-MM-dd', 'en').format(endDate));
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
          title: S.of(context).storesReports, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

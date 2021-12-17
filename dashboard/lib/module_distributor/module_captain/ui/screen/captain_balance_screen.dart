import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/state_manager/captain_balance_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class CaptainBalanceScreen extends StatefulWidget {
  final CaptainBalanceStateManager _stateManager;

  CaptainBalanceScreen(this._stateManager);

  @override
  CaptainBalanceScreenState createState() => CaptainBalanceScreenState();
}

class CaptainBalanceScreenState extends State<CaptainBalanceScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  void getCaptain() {
   // widget._stateManager.getCaptainBalance(this, captainId);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  int captainId = -1;
  int currentIndex = 0;
  DateTime? fDate;
  DateTime? lDate;

  void getBalanceFilteredDate(DateTime firstDate, DateTime endDate,
      captainBalance, captainBalanceLastMonth) {
    fDate = firstDate;
    lDate = endDate;
    // widget._stateManager.getBalanceFilteredDate(
    //     this,
    //     captainId,
    //     captainBalance,
    //     captainBalanceLastMonth,
    //     DateFormat('yyyy-MM-dd', 'en').format(firstDate.toUtc()),
    //     DateFormat('yyyy-MM-dd', 'en').format(endDate.toUtc()));
  }

  @override
  Widget build(BuildContext context) {
    if (captainId == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        captainId = arg;
      //  widget._stateManager.getCaptainBalance(this, captainId);
      }
    }
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(
        context,
        title: S.current.balanceDetails,
      ),
      body: currentState.getUI(context),
    );
  }
}

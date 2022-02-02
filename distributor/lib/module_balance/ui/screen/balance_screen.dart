import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_balance/model/balance_model.dart';
import 'package:mandob_moshtarayat/module_balance/state_manager/balance_state_manager.dart';
import 'package:mandob_moshtarayat/module_balance/ui/state/balance_loaded_state.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/ui/widget/add_store_widget.dart';
import 'package:mandob_moshtarayat/module_stores/state_manager/store_state_manager.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';



@injectable
class BalanceScreen extends StatefulWidget {
  final BalanceStateManager _stateManager;

  BalanceScreen(this._stateManager);

  @override
  BalanceScreenState createState() =>
      BalanceScreenState();
}

class BalanceScreenState
    extends State<BalanceScreen> {
  late States currentState;
  late BalanceModel _model;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getOrders() async {
//    widget._stateManager.getOrders(this);
  }



  @override
  void initState() {
    _model = BalanceModel(sumRepresentativeDue: 0, sumPaymentToRepresentative: 0, totalRemainingPaymentsToRepresentative: 0, payments: []);
    currentState = BalanceLoadedState(this,_model);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  DateTime? fDate;
  DateTime? lDate;
  void getOrderFilteredDate(DateTime firstDate, DateTime endDate) {
    fDate = firstDate;
    lDate = endDate;
    widget._stateManager.getFilteredDateBalance(
        this,
        DateFormat('yyyy-MM-dd', 'en').format(firstDate),
        DateFormat('yyyy-MM-dd', 'en').format(endDate));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomMandobAppBar.appBar(context,
            title: S.of(context).myBalance, icon: Icons.arrow_back, onTap: () {
              Navigator.pop(context);
            }),
        body: currentState.getUI(context),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

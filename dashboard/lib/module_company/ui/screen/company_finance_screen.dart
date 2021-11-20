import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/create_company_profile.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/delivery_company_financial.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/financial_compensation_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/state_manager/company_financial_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/state_manager/company_profile_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class CompanyFinanceScreen extends StatefulWidget {
  final CompanyFinanceStateManager _stateManager;

  CompanyFinanceScreen(this._stateManager);

  @override
  CompanyFinanceScreenState createState() => CompanyFinanceScreenState();
}

class CompanyFinanceScreenState extends State<CompanyFinanceScreen> {
  late States currentState;
  bool canAddCategories = true;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        refresh();
      }
    });
    widget._stateManager.getFinance(this);
    super.initState();
  }

  void getFinance() {
    widget._stateManager.getFinance(this);
  }

  void updateFinancial(
      FinancialCompensationRequest financialCompensationRequest,
      DeliveryCompanyFinancialRequest deliverRequest) {
    widget._stateManager
        .updateFinancial(this, financialCompensationRequest, deliverRequest);
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
          title: S.of(context).companyFinance, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: GestureDetector(
          onTap: () {
            var focus = FocusScope.of(context);
            if (focus.canRequestFocus) {
              focus.unfocus();
            }
          },
          child: currentState.getUI(context)),
    );
  }
}

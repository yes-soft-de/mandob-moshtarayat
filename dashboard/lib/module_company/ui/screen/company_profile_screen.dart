import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/create_company_profile.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/state_manager/company_profile_state_manager.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';

@injectable
class CompanyProfileScreen extends StatefulWidget {
  final CompanyProfileStateManager _stateManager;

  CompanyProfileScreen(this._stateManager);

  @override
  CompanyProfileScreenState createState() => CompanyProfileScreenState();
}

class CompanyProfileScreenState extends State<CompanyProfileScreen> {
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
    widget._stateManager.getCompanyProfile(this);
    super.initState();
  }

  void getCompanyProfile() {
    widget._stateManager.getCompanyProfile(this);
  }

  void createProfile(CreateCompanyProfile request) {
    widget._stateManager.createProfile(this, request);
  }

  void updateProfile(CreateCompanyProfile request) {
    widget._stateManager.updateStore(this, request);
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
          title: S.of(context).companyInfo, icon: Icons.menu, onTap: () {
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

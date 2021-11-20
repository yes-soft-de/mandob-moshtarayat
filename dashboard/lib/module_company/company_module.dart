import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/company_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/ui/screen/company_finance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/ui/screen/company_profile_screen.dart';

@injectable
class CompanyModule extends YesModule {
  final CompanyProfileScreen companyProfileScreen;
  final CompanyFinanceScreen companyFinanceScreen;
  CompanyModule(this.companyProfileScreen, this.companyFinanceScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CompanyRoutes.COMPANY_PROFILE_SCREEN: (context) => companyProfileScreen,
      CompanyRoutes.COMPANY_FINANCE_SCREEN: (context) => companyFinanceScreen
    };
  }
}

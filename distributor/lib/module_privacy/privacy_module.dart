import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_privacy/policy_routes.dart';
import 'package:mandob_moshtarayat/module_settings/setting_routes.dart';
import 'package:mandob_moshtarayat/module_settings/ui/settings_page/settings_page.dart';

import 'ui/policies_page/about_page.dart';
import 'ui/policies_page/policy_page.dart';
import 'ui/policies_page/terms_page.dart';

@injectable
class PrivacyModule extends YesModule {
  final TermOfServicePage termOfServicePage;
  final PolicyPage policyPage;
  final AboutUsPage aboutUsPage;
  PrivacyModule(this.termOfServicePage, this.policyPage, this.aboutUsPage) {
    YesModule.RoutesMap.addAll({
      PoliciesRoutes.ROUTE_ABOUT: (context) => aboutUsPage,
      PoliciesRoutes.ROUTE_POLICE: (context) => policyPage,
      PoliciesRoutes.ROUTE_TERM: (context) => termOfServicePage,
    });
  }
}

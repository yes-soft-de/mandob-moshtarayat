import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/captains_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captain_balance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captain_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captains_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/catpains_payment_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/in_active_captains_screen.dart';

@injectable
class CaptainsModule extends YesModule {
  final InActiveCaptainsScreen inActiveCaptains;
  final CaptainsScreen captainsScreen;
  final CaptainProfileScreen captainProfileScreen;
  final CaptainBalanceScreen captainBalanceScreen;
  final CaptainsPaymentsScreen captainsPaymentsScreen;
  CaptainsModule(
      this.inActiveCaptains,
      this.captainProfileScreen,
      this.captainBalanceScreen,
      this.captainsPaymentsScreen,
      this.captainsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CaptainsRoutes.IN_ACTIVE_CAPTAINS: (context) => inActiveCaptains,
      CaptainsRoutes.CAPTAIN_PROFILE: (context) => captainProfileScreen,
      CaptainsRoutes.CAPTAIN_BALANCE: (context) => captainBalanceScreen,
      CaptainsRoutes.CAPTAIN_UNFINISHED: (context) => captainsPaymentsScreen,
      CaptainsRoutes.CAPTAINS: (context) => captainsScreen,
    };
  }
}

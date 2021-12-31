import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/captains_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captain_balance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captain_profile_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captains_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/catpains_payment_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/distros_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distors_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/in_active_distros_screen.dart';

@injectable
class DistributorsModule extends YesModule {
  final DistrosScreen distro_screen;
  final InActiveDistributorsScreen inActiveDistributorsScreen;
  final CaptainProfileScreen captainProfileScreen;
  final CaptainBalanceScreen captainBalanceScreen;
  final CaptainsPaymentsScreen captainsPaymentsScreen;
  DistributorsModule(
      this.distro_screen,
      this.captainProfileScreen,
      this.captainBalanceScreen,
      this.captainsPaymentsScreen,
      this.inActiveDistributorsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      DistributorRoutes.DISTROS: (context) => distro_screen,
      DistributorRoutes.IN_ACTIVE_DISTRO: (context) =>
          inActiveDistributorsScreen,
      CaptainsRoutes.CAPTAIN_PROFILE: (context) => captainProfileScreen,
      CaptainsRoutes.CAPTAIN_BALANCE: (context) => captainBalanceScreen,
      CaptainsRoutes.CAPTAIN_UNFINISHED: (context) => captainsPaymentsScreen,
    };
  }
}

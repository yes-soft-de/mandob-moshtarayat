import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/captains_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captain_balance_screen.dart';
  import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/catpains_payment_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/distros_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distors_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/in_active_distros_screen.dart';

import 'ui/screen/distros_profile_screen.dart';

@injectable
class DistributorsModule extends YesModule {
  final DistrosScreen distro_screen;
  final InActiveDistributorsScreen inActiveDistributorsScreen;
  final DistrosProfileScreen distrosProfileScreen;
  final CaptainBalanceScreen captainBalanceScreen;
  final CaptainsPaymentsScreen captainsPaymentsScreen;
  DistributorsModule(
      this.distro_screen,
      this.distrosProfileScreen,
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
      DistributorRoutes.DISTRO_PROFILE: (context) => distrosProfileScreen,
      CaptainsRoutes.CAPTAIN_BALANCE: (context) => captainBalanceScreen,
      CaptainsRoutes.CAPTAIN_UNFINISHED: (context) => captainsPaymentsScreen,
    };
  }
}

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/distros_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distors_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distros_balance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/in_active_distros_screen.dart';

import 'ui/screen/distros_payment_screen.dart';
import 'ui/screen/distros_profile_screen.dart';

@injectable
class DistributorsModule extends YesModule {
  final DistrosScreen distro_screen;
  final InActiveDistributorsScreen inActiveDistributorsScreen;
  final DistrosProfileScreen distrosProfileScreen;
  final DistroBalanceScreen distroBalanceScreen;
  final DistrosPaymentsScreen distrosPaymentsScreen;
  DistributorsModule(
      this.distro_screen,
      this.distrosProfileScreen,
      this.distroBalanceScreen,
      this.distrosPaymentsScreen,
      this.inActiveDistributorsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      DistributorRoutes.DISTROS: (context) => distro_screen,
      DistributorRoutes.IN_ACTIVE_DISTRO: (context) =>
          inActiveDistributorsScreen,
      DistributorRoutes.DISTRO_PROFILE: (context) => distrosProfileScreen,
      DistributorRoutes.DISTRO_BALANCE: (context) => distroBalanceScreen,
      DistributorRoutes.DISTRO_UNFINISHED: (context) => distrosPaymentsScreen,
    };
  }
}

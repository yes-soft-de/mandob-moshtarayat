import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/portals_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/ui/screen/paymen_from_captain_screen.dart';

@injectable
class PortalsModule extends YesModule {
  final PortalScreen portalScreen;
  PortalsModule(this.portalScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      PortalsRoutes.PORTALS: (context) => portalScreen,
    };
  }
}

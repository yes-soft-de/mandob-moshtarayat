import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/captains_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/reports_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/screen/captains_reports_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/screen/clients_reports_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/screen/products_reports_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/screen/stores_reports_screen.dart';

@injectable
class ReportsModule extends YesModule {
  final CaptainsReportScreen captainsReportScreen;
  final StoresReportScreen storesReportScreen;
  final ProductsReportScreen productsReportScreen;
  final ClientsReportScreen clientsReportScreen;

  ReportsModule(this.productsReportScreen, this.storesReportScreen,
      this.captainsReportScreen, this.clientsReportScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ReportsRoutes.REPORTS_CAPTAIN: (context) => captainsReportScreen,
      ReportsRoutes.REPORTS_STORE: (context) => storesReportScreen,
      ReportsRoutes.REPORTS_CLIENT: (context) => clientsReportScreen,
      ReportsRoutes.REPORTS_PRODUCT: (context) => productsReportScreen,
    };
  }
}

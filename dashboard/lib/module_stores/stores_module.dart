import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';

import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/stores_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/store_balance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/store_info_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/stores_inactive_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/stores_screen.dart';

@injectable
class StoresModule extends YesModule {
  final StoresScreen storesScreen;
  final StoreInfoScreen _storeInfoScreen;
  final StoresInActiveScreen storesInActiveScreen;
  final StoreBalanceScreen storeBalanceScreen;
  StoresModule(this.storesScreen, this._storeInfoScreen,
      this.storesInActiveScreen, this.storeBalanceScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      StoresRoutes.STORES: (context) => storesScreen,
      StoresRoutes.STORE_INFO: (context) => _storeInfoScreen,
      StoresRoutes.STORES_INACTIVE: (context) => storesInActiveScreen,
      StoresRoutes.STORE_BALANCE: (context) => storeBalanceScreen
    };
  }
}

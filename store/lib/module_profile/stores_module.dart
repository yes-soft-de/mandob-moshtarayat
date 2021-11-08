import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_profile/stores_routes.dart';
import 'package:mandob_moshtarayat/module_profile/ui/screen/store_info_screen.dart';


@injectable
class StoresModule extends YesModule {
  // final StoresScreen storesScreen;
  final StoreInfoScreen _storeInfoScreen;
  // final StoresInActiveScreen storesInActiveScreen;
  StoresModule(this._storeInfoScreen,){
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      // StoresRoutes.STORES : (context) => storesScreen,
      StoresRoutes.STORE_INFO : (context) => _storeInfoScreen,
      // StoresRoutes.STORES_INACTIVE : (context) => storesInActiveScreen
    };
  }
}
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_profile/stores_routes.dart';
import 'package:mandob_moshtarayat/module_profile/ui/screen/store_info_screen.dart';


@injectable
class StoresProfileModule extends YesModule {
  final StoreInfoScreen _storeInfoScreen;
  StoresProfileModule(this._storeInfoScreen,){
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      StoresProfileRoutes.STORE_INFO : (context) => _storeInfoScreen,
    };
  }
}
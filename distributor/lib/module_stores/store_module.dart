import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_screen.dart';


@injectable
class StoreModule extends YesModule {
  final StoreScreen _storeScreen;
  StoreModule(this._storeScreen,){
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      StoreRoutes.STORES : (context) => _storeScreen,
    };
  }
}
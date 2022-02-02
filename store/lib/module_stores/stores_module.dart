import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_stores/stores_routes.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/stores_screen.dart';

@injectable
class StoresModule extends YesModule {
  final StoresScreen _homeScreen;
  StoresModule(this._homeScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {StoresRoutes.STORES_SCREEN: (context) => _homeScreen};
  }
}

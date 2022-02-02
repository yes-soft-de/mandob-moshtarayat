import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/module_main/ui/screen/main_screen.dart';

@injectable
class MainModule extends YesModule {
  final MainScreen _mainScreen;
  MainModule(this._mainScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {MainRoutes.MAIN_SCREEN: (context) => _mainScreen};
  }
}

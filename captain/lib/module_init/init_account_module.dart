import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_captain/module_init/init_routes.dart';
import 'package:mandob_moshtarayat_captain/module_init/ui/screens/init_account_screen/init_account_screen.dart';

@injectable
class InitAccountModule extends YesModule {
  final InitAccountScreen _initAccountScreen;

  InitAccountModule(this._initAccountScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      InitAccountRoutes.INIT_ACCOUNT_SCREEN: (context) => _initAccountScreen
    };
  }
}

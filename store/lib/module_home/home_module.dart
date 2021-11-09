import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_screen.dart';

import 'home_routes.dart';

@injectable
class HomeModule extends YesModule {
  final HomeScreen homeScreen;
  HomeModule(this.homeScreen){
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      HomeRouts.HOME_SCREEN : (context) => homeScreen
    };
  }
}
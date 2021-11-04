import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_my_notifications/my_notifications_routes.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/screen/my_notifications_screen.dart';

@injectable
class MyNotificationsModule extends YesModule {
  final MyNotificationsScreen _myNotificationsScreen;

  MyNotificationsModule(this._myNotificationsScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      MyNotificationsRoutes.MY_NOTIFICATIONS: (context) =>
          _myNotificationsScreen
    };
  }
}

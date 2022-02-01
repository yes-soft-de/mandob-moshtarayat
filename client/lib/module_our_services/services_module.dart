import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_our_services/services_routes.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/screen/private_order_screen.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/screen/send_it_screen.dart';

@injectable
class ServicesModule extends YesModule {
  final SendItScreen _sendItScreen;
  final PrivateOrderScreen _privateOrderScreen;
  ServicesModule(this._sendItScreen, this._privateOrderScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ServicesRoutes.SEND_IT: (context) => _sendItScreen,
      ServicesRoutes.PRIVATE_ORDER: (context) => _privateOrderScreen
    };
  }
}

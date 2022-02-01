import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_balance/ui/screen/balance_screen.dart';

import 'balance_routes.dart';


@injectable
class BalanceModule extends YesModule {
  final BalanceScreen _storeScreen;
  BalanceModule(this._storeScreen,){
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      BalanceRoutes.BALANCE : (context) => _storeScreen,
    };
  }
}
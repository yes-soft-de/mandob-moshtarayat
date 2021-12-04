import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_balance/ui/screen/balance_info_screen.dart';

import 'balance_routes.dart';

@injectable
class BalanceModule extends YesModule {
  final BalanceScreen _balanceScreen;
  BalanceModule(this._balanceScreen){
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      BalanceRoutes.STORE_PAYMENTS : (context) => _balanceScreen
    };
  }
}
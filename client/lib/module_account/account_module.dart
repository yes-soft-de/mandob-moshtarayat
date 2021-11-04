import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_account/account_routes.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/account_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/presonal_data_screen.dart';

@injectable
class AccountModule extends YesModule {
  final AccountScreen _accountScreen;
  final PersonalDataScreen _personalDataScreen;

  AccountModule(this._accountScreen, this._personalDataScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      AccountRoutes.ACCOUNT: (context) => _accountScreen,
      AccountRoutes.PERSONAL_DATA: (context) => _personalDataScreen
    };
  }
}

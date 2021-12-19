import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_account/account_routes.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/about.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/account_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/presonal_data_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/privecy_policy.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/terms_of_use.dart';

@injectable
class AccountModule extends YesModule {
  final AccountScreen _accountScreen;
  final PersonalDataScreen _personalDataScreen;
  final AboutScreen _aboutScreen;
  final PrivecyPolicy _privecyPolicy;
  final TermsOfUse _termsOfUse;
  AccountModule(this._accountScreen, this._personalDataScreen,this._aboutScreen,this._privecyPolicy,this._termsOfUse) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      AccountRoutes.ACCOUNT: (context) => _accountScreen,
      AccountRoutes.PERSONAL_DATA: (context) => _personalDataScreen,
      AccountRoutes.ABOUT_SCREEN: (context) => _aboutScreen,
      AccountRoutes.PRIVECY_POLICY: (context) => _privecyPolicy,
      AccountRoutes.TERMS_OF_USE: (context) => _termsOfUse,

    };
  }
}

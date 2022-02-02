import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_captain/module_settings/setting_routes.dart';
import 'package:mandob_moshtarayat_captain/module_settings/ui/settings_page/choose_local_page.dart';
import 'package:mandob_moshtarayat_captain/module_settings/ui/settings_page/screen/privecy_policy.dart';
import 'package:mandob_moshtarayat_captain/module_settings/ui/settings_page/screen/terms_of_use.dart';
import 'package:mandob_moshtarayat_captain/module_settings/ui/settings_page/settings_page.dart';

@injectable
class SettingsModule extends YesModule {
  final SettingsScreen settingsScreen;
  final ChooseLocalScreen chooseLocalScreen;
  final PrivecyPolicy privecyPolicy;
  final TermsOfUse termsOfUse;
  SettingsModule(this.settingsScreen, this.chooseLocalScreen,
      this.privecyPolicy, this.termsOfUse) {
    YesModule.RoutesMap.addAll({
      SettingRoutes.ROUTE_SETTINGS: (context) => settingsScreen,
      SettingRoutes.CHOOSE_LANGUAGE: (context) => chooseLocalScreen,
      SettingRoutes.TERMS: (context) => termsOfUse,
      SettingRoutes.PRIVECY: (context) => privecyPolicy
    });
  }
}

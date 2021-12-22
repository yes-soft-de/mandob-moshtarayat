import 'package:injectable/injectable.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';

@injectable
class SettingsScreen extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final AppThemeDataService _themeDataService;
  final FireNotificationService _notificationService;

  const SettingsScreen(
    this._authService,
    this._localizationService,
    this._themeDataService,
    this._notificationService,
  );

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).settings,
          colorIcon: Theme.of(context).brightness != Brightness.dark
              ? Theme.of(context).disabledColor
              : Colors.white,
          buttonBackground: Theme.of(context).backgroundColor),
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: ListView(
          physics:
              const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Container(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).backgroundColor,
              ),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  ListTileSwitch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    leading: Icon(
                        Theme.of(context).brightness == Brightness.dark
                            ? Icons.nightlight_round_rounded
                            : Icons.wb_sunny),
                    onChanged: (mode) {
                      widget._themeDataService.switchDarkMode(mode);
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Theme.of(context).primaryColor,
                    title: Text(S.of(context).darkMode),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(S.of(context).language),
                    trailing: DropdownButton(
                        value: Localizations.localeOf(context).languageCode,
                        underline: Container(),
                        icon: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.arrow_drop_down_rounded),
                        ),
                        items: const [
                          DropdownMenuItem(
                            child: Text('العربية'),
                            value: 'ar',
                          ),
                          DropdownMenuItem(
                            child: Text('English'),
                            value: 'en',
                          ),
                          DropdownMenuItem(
                            child: Text('اردو'),
                            value: 'ur',
                          ),
                        ],
                        onChanged: (newLang) {
                          widget._localizationService
                              .setLanguage(newLang.toString());
                        }),
                  ),
                  Hider(
                    active: widget._authService.isLoggedIn,
                    child: ListTile(
                      leading: const Icon(Icons.person_rounded),
                      title: Text(S.of(context).signOut),
                      trailing: const Padding(
                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                        child: Icon(Icons.logout_rounded),
                      ),
                      onTap: () {
                        widget._authService.logout().then((value) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              MainRoutes.MAIN_SCREEN, (route) => false);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

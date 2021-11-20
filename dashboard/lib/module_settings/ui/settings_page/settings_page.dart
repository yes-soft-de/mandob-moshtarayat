import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';

@injectable
class SettingsScreen extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final AppThemeDataService _themeDataService;
  final FireNotificationService _notificationService;

  SettingsScreen(
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
          title: S.of(context).settings, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: FixedContainer(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).primaryColor,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    ListTileSwitch(
                      value: Theme.of(context).brightness == Brightness.dark,
                      leading: Icon(
                          Theme.of(context).brightness == Brightness.dark
                              ? Icons.nightlight_round_rounded
                              : Icons.wb_sunny,
                          color: Colors.white),
                      onChanged: (mode) {
                        widget._themeDataService.switchDarkMode(mode);
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      title: Text(
                        S.of(context).darkMode,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.language, color: Colors.white),
                      title: Text(
                        S.of(context).language,
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: DropdownButton(
                          dropdownColor: Theme.of(context).primaryColor,
                          value: Localizations.localeOf(context).languageCode,
                          style: TextStyle(color: Colors.white),
                          underline: Container(),
                          icon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.arrow_drop_down_rounded,
                                color: Colors.white),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                'العربية',
                                style: TextStyle(),
                              ),
                              value: 'ar',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'English',
                                style: TextStyle(),
                              ),
                              value: 'en',
                            ),
                          ],
                          onChanged: (newLang) {
                            widget._localizationService
                                .setLanguage(newLang.toString());
                          }),
                    ),
                    ListTile(
                      leading: Icon(Icons.person_rounded, color: Colors.white),
                      title: Text(
                        S.of(context).signOut,
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                        child: Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        widget._authService.logout().then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              AuthorizationRoutes.LOGIN_SCREEN,
                              (route) => false);
                        });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

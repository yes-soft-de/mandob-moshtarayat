import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/di/di_config.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_main/main_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_settings/setting_routes.dart';

@injectable
class SplashScreen extends StatefulWidget {
  final AuthService _authService;
  SplashScreen(this._authService);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _getNextRoute().then((route) {
        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(),
    );
  }

  Future<String> _getNextRoute() async {
    if (widget._authService.isLoggedIn) {
      return MainRoutes.MAIN_SCREEN;
    }
    if (getIt<LocalizationService>().choosed() == false) {
      return SettingRoutes.CHOOSE_LANGUAGE;
    }
    return AuthorizationRoutes.LOGIN_SCREEN;
  }
}

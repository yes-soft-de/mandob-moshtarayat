import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/module_settings/setting_routes.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:flutter/material.dart';

@injectable
class SplashScreen extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;

  const SplashScreen(this._authService, this._localizationService);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _getNextRoute().then((route) {
        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var paddingOfImage = MediaQuery.of(context).size.height * 0.20;
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.only(top: paddingOfImage, bottom: 24),
            child: Image.asset(
              ImageAsset.LOGO,
              height: 200,
              width: 200,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Image.asset(
            ImageAsset.DELIVERY_MOTOR,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  Future<String> _getNextRoute() async {
    await Future.delayed(const Duration(seconds: 2));
    if (widget._localizationService.choosed()) {
      return MainRoutes.MAIN_SCREEN;
    }
    return SettingRoutes.CHOOSE_LANGUAGE;
  }
}

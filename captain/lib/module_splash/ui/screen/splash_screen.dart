import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_about/about_routes.dart';
import 'package:mandob_moshtarayat_captain/module_about/service/about_service/about_service.dart';
import 'package:mandob_moshtarayat_captain/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/module_init/init_routes.dart';
import 'package:mandob_moshtarayat_captain/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat_captain/module_settings/setting_routes.dart';
import 'package:mandob_moshtarayat_captain/utils/images/images.dart';

@injectable
class SplashScreen extends StatefulWidget {
  final AuthService _authService;
  final AboutService _aboutService;
  SplashScreen(this._authService, this._aboutService);

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
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(flex: 1,),
          Padding(
            padding: EdgeInsets.only(),
            child: Image.asset(ImageAsset.LOGO,width: 200,height: 200,),
          ),
          Spacer(flex: 1,),
          Image.asset(
            ImageAsset.DELIVERY_MOTOR,
          ),
        ],
      ),
    );
  }

  Future<String> _getNextRoute() async {
    bool signIn = await widget._authService.isLoggedIn;
    bool init = await widget._aboutService.isInitialized();
    bool needInitAccount = await widget._authService.needToInitAccount;
    await Future.delayed(Duration(seconds: 2));
    if (init) {
      if (signIn) {
        return needInitAccount
            ? InitAccountRoutes.INIT_ACCOUNT_SCREEN
            : OrdersRoutes.CAPTAIN_ORDERS_SCREEN;
      } else {
        return AuthorizationRoutes.REGISTER_SCREEN;
      }
    } else {
      if (signIn) {
        return OrdersRoutes.CAPTAIN_ORDERS_SCREEN;
      }
      return SettingRoutes.CHOOSE_LANGUAGE;
    }
  }
}

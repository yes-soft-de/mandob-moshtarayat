import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

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
    var paddingOfImage = MediaQuery.of(context).size.height * 0.08;
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.only(top:paddingOfImage,left: paddingOfImage,right: paddingOfImage,bottom: 24),
            child: Image.asset(ImageAsset.LOGO),
          ),
          Center(
            child: Text(S.of(context).welcomeTomandob_moshtarayat,style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
          ),
          Expanded(child:Image.asset(ImageAsset.DELIVERY_CAR,fit: BoxFit.cover,
            alignment: Alignment.bottomRight,)),
        ],
      ),
    );
  }

  Future<String> _getNextRoute() async {
    await Future.delayed(Duration(seconds: 3));
    if (widget._authService.isLoggedIn) {
      return MainRoutes.MAIN_SCREEN;
    }
    return AuthorizationRoutes.LOGIN_SCREEN;
  }
}

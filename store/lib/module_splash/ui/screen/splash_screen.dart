import 'package:injectable/injectable.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat/module_main/main_routes.dart';
import 'package:mandob_moshtarayat/module_splash/ui/widget/costum_button.dart';
import 'package:mandob_moshtarayat/module_stores/stores_routes.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

@injectable
class SplashScreen extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  SplashScreen(this._authService, this._localizationService);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      IsFirstRun.isFirstRun().then((value) {
        if(value){
          _showAlertDialog();
        }else {
          _getNextRoute().then((route) {
            Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
          });
        }
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

  _getNextRoutFirst(){
    if (widget._authService.isLoggedIn) {
      return   Navigator.of(context).pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
    }
    return Navigator.of(context).pushNamedAndRemoveUntil(StoresRoutes.STORES_SCREEN, (route) => false);
  }

  Future<String> _getNextRoute() async {
    await Future.delayed(Duration(seconds: 3));
    if (widget._authService.isLoggedIn) {
      return MainRoutes.MAIN_SCREEN;
    }
    return StoresRoutes.STORES_SCREEN;
  }


  _showAlertDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return    AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(S.of(context).selectLanguage , textAlign: TextAlign.center,),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomAppButton(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(3),
                elevation: 0,
                color: Colors.white,
                onTap: (){
               widget._localizationService
                                .setLanguage('ar');
               Navigator.pop(context);
               _getNextRoutFirst();
                },
                child: Text('العربية')
              ),
              SizedBox(width: 16,),
              CustomAppButton(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(3),
                elevation: 0,
                color: Colors.white,
                onTap: (){
                  widget._localizationService
                      .setLanguage('en');
                  Navigator.pop(context);
                  _getNextRoutFirst();
                },
                child: Text('English'),
              ),
            ],
          ),
        );
      },
    );
  }
}

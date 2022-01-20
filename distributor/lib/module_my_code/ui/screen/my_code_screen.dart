import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_home/home_routes.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_splash/ui/widget/costum_button.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:qr_flutter/qr_flutter.dart';


@injectable
class MyCodeScreen extends StatefulWidget {

//  final AuthService _authService;
//  final LocalizationService _localizationService;
  MyCodeScreen( );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MyCodeScreen> {
  ProfileModel? profileModel;
  String? id;
  @override
  void initState() {
    super.initState();
  }

  var args;
  @override
  Widget build(BuildContext context) {
        args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is ProfileModel) {
      profileModel = args;
      id =profileModel?.mandobID;
    }
    return Scaffold(
      appBar: CustomMandobAppBar.appBar(context,
          title: S.of(context).myCode),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    color: Theme.of(context).dialogBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        CircleAvatar(backgroundImage: NetworkImage(profileModel?.image??''),radius: 45,),
                        SizedBox(height: 10,),
                        Text(profileModel?.mandobName??'' , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold),),
                        SizedBox(height: 8,),
                        Text(profileModel?.phone??'' ,style: TextStyle(fontSize: 13 )),
                        SizedBox(height: 15,),
                        QrImage(
                          data: Urls.GOOGLE_LINK +'$id',
                          version: QrVersions.auto,
                          size: 230.0,
                         ),
                      ],),
                    ),),
                ),
                Image.asset(ImageAsset.LOGO,height: 100,)
              ],
            ),
//          children: [
////            CircleAvatar(backgroundImage: NetworkImage(''),)
//
//          ],
          ),
        ),
      ),
    );
  }


}

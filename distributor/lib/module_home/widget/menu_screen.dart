import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/consts/social_type.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_screen.dart';
import 'package:mandob_moshtarayat/module_privacy/policy_routes.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/profile_routes.dart';
import 'package:mandob_moshtarayat/module_settings/setting_routes.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/components/social_widget.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatelessWidget {
  final HomeScreenState screenState;
  final ProfileModel profileModel;
  MenuScreen(this.screenState, this.profileModel);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomNetworkImage(
                      background: Theme.of(context).scaffoldBackgroundColor,
                      imageSource: profileModel.image ??
                          'https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png',
                      width: double.maxFinite,
                      height: double.maxFinite,
                    ),
                  ),
                ),
              ),
              Text(profileModel.mandobName),
              Container(
                height: 32,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ProfileRoutes.PROFILE);
                },
                leading:Container(
                    decoration: BoxDecoration(
                        color: AppThemeDataService.PrimaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.account_circle_rounded,color: Colors.white,),
                    )),
                title: Text('${S.of(context).profile}'),
                trailing: Container(
                    decoration: BoxDecoration(
                        color: StyleText.geyApp,
                        borderRadius: BorderRadius.circular(8)),

                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(Icons.arrow_forward),
                    )),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed( StoreRoutes.STORES);
                },
                leading: Container(
                    decoration: BoxDecoration(
                        color: AppThemeDataService.PrimaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.shopping_basket,color: Colors.white,),
                    )),
                title: Text('${S.of(context).stores}'),
                trailing: Container(
                    decoration: BoxDecoration(
                        color: StyleText.geyApp,
                        borderRadius: BorderRadius.circular(8)),

                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(Icons.arrow_forward),
                    )),

              ),
              ListTile(
                onTap: () {
                  // if (screenState.currentState is CaptainOrdersListStateOrdersLoaded){
                  //   screenState.currentState = CaptainOrdersListStateLoading(screenState);
                  //   screenState.getMyOrders();
                  // }
                  Navigator.of(context).pushNamed(SettingRoutes.ROUTE_SETTINGS);
                },
                leading: Container(
                    decoration: BoxDecoration(
                        color: AppThemeDataService.PrimaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.settings,color: Colors.white,),
                    )),
                title: Text('${S.of(context).settings}'),
                trailing: Container(
                    decoration: BoxDecoration(
                        color: StyleText.geyApp,
                        borderRadius: BorderRadius.circular(8)),

                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(Icons.arrow_forward),
                    )),

              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(PoliciesRoutes.ROUTE_TERM);
                },
                leading: Container(
                    decoration: BoxDecoration(
                        color: AppThemeDataService.PrimaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.sticky_note_2_rounded,color: Colors.white,),
                    )),
                title: Text('${S.of(context).termsOfService}'),
                trailing: Container(
                    decoration: BoxDecoration(
                        color: StyleText.geyApp,
                        borderRadius: BorderRadius.circular(8)),

                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(Icons.arrow_forward),
                    )),

              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(PoliciesRoutes.ROUTE_POLICE);
                },
                leading: Container(
                    decoration: BoxDecoration(
                        color: AppThemeDataService.PrimaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.sticky_note_2_rounded,color: Colors.white,),
                    )),
                title: Text('${S.of(context).privacyPolicy}'),
                trailing: Container(
                    decoration: BoxDecoration(
                        color: StyleText.geyApp,
                        borderRadius: BorderRadius.circular(8)),

                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(Icons.arrow_forward),
                    )),

              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(PoliciesRoutes.ROUTE_ABOUT);
                },
                leading: Container(
                    decoration: BoxDecoration(
                        color: AppThemeDataService.PrimaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.info,color: Colors.white,),
                    )),
                title: Text('${S.of(context).about}'),
                trailing: Container(
                    decoration: BoxDecoration(
                        color: StyleText.geyApp,
                        borderRadius: BorderRadius.circular(8)),

                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(Icons.arrow_forward),
                    )),

              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SocialWidget(
                        image: FontAwesomeIcons.twitter,
                        type: SocialType.twitter,
                        color: Colors.cyan,
                        onTap: () {
                          launch(
                              'https://m.facebook.com/profile.php?id=100073436632320');
                        },
                      ),
                      SocialWidget(
                        image: FontAwesomeIcons.tiktok,
                        type: SocialType.tiktok,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        onTap: () {
                          launch('https://www.tiktok.com/@mandoob_quick');
                        },
                      ),
                      SocialWidget(
                        image: FontAwesomeIcons.instagram,
                        type: SocialType.instagram,
                        color: Colors.pink,
                        onTap: () {
                          launch('https://www.instagram.com/mandoob_quick');
                        },
                      ),
                      SocialWidget(
                        image: FontAwesomeIcons.facebook,
                        type: SocialType.facebook,
                        color: Colors.blue,
                        onTap: () {
                          launch(
                              'https://m.facebook.com/profile.php?id=100073436632320');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
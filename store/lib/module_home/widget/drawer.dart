import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/consts/social_type.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_balance/balance_routes.dart';
import 'package:mandob_moshtarayat/module_categories/categories_routes.dart';
import 'package:mandob_moshtarayat/module_my_notifications/my_notifications_routes.dart';
import 'package:mandob_moshtarayat/module_orders/orders_module.dart';
import 'package:mandob_moshtarayat/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat/module_privacy/policy_routes.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/stores_routes.dart';
import 'package:mandob_moshtarayat/module_settings/setting_routes.dart';
import 'package:mandob_moshtarayat/module_stores/stores_routes.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/components/social_widget.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatelessWidget {
  final bool isLoggedIn;
  MenuScreen( this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: SingleChildScrollView(
        physics:
        BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(StoresProfileRoutes.STORE_INFO);
              },
              leading: Container(
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
                Navigator.of(context)
                    .pushNamed(CategoriesRoutes.PRODUCT_STORE);
              },
              leading: Container(
                  decoration: BoxDecoration(
                      color: AppThemeDataService.PrimaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.category,color: Colors.white,),
                  )),
              title: Text('${S.of(context).products}'),
              trailing: Container(
                decoration: BoxDecoration(
                    color: StyleText.geyApp,
                    borderRadius: BorderRadius.circular(8)),

                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(Icons.arrow_forward),
                  )),
            ),
            isLoggedIn ?Container():
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, CategoriesRoutes.PRODUCT_CATEGORIES,arguments: 1);
              },
              leading: Container(
                  decoration: BoxDecoration(
                      color: AppThemeDataService.PrimaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.add,color: Colors.white,),
                  )),
              title: Text('${S.of(context).addProducts}'),
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
                Navigator.pushNamed(context, BalanceRoutes.STORE_PAYMENTS ,arguments: 1);
              },
              leading: Container(
                  decoration: BoxDecoration(
                      color: AppThemeDataService.PrimaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.monetization_on,color: Colors.white,),
                  )),
              title: Text('${S.of(context).balanceDetails}'),
              trailing: Container(
                  decoration: BoxDecoration(
                      color: StyleText.geyApp,
                      borderRadius: BorderRadius.circular(8)),

                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(Icons.arrow_forward),
                  )),
            ),

//              ListTile(
//                onTap: () {
//                  Navigator.of(context)
//                      .pushNamed(OrdersRoutes.ORDERS);
//                },
//                leading: Container(
//                    decoration: BoxDecoration(
//                        color: AppThemeDataService.PrimaryColor,
//                        borderRadius: BorderRadius.circular(8)),
//                    child: Padding(
//                      padding: const EdgeInsets.all(5.0),
//                      child: Icon(Icons.history,color: Colors.white,),
//                    )),
//                title: Text('${S.of(context).orderLog}'),
//                trailing: Container(
//                    decoration: BoxDecoration(
//                        color: StyleText.geyApp,
//                        borderRadius: BorderRadius.circular(8)),
//
//                    child: Padding(
//                      padding: const EdgeInsets.all(3.0),
//                      child: Icon(Icons.arrow_forward),
//                    )),
//
//              ),

            isLoggedIn?  ListTile(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(StoresRoutes.STORES_SCREEN);
              },
              leading: Container(
                  decoration: BoxDecoration(
                      color: AppThemeDataService.PrimaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.store,color: Colors.white,),
                  )),
              title: Text('${S.of(context).anotherStore}'),
              trailing: Container(
                  decoration: BoxDecoration(
                      color: StyleText.geyApp,
                      borderRadius: BorderRadius.circular(8)),

                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(Icons.arrow_forward),
                  )),

            ):Container(),
            ExpansionTile(
                title: Text(S.current.orderLog),
                leading: Container(
                    decoration: BoxDecoration(
                        color: AppThemeDataService.PrimaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.history,color: Colors.white,),
                    )),
                trailing: Container(
                    decoration: BoxDecoration(
                        color: StyleText.geyApp,
                        borderRadius: BorderRadius.circular(8)),

                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(Icons.arrow_downward),
                    )),
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10.0),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(OrdersRoutes.PENDING_ORDERS);
                          },
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: AppThemeDataService.PrimaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(FontAwesomeIcons.solidClock,color: Colors.white,size: 15,),
                              )),
                          title: Text('${S.of(context).orderPending}'),
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
                            Navigator.of(context)
                                .pushNamed(OrdersRoutes.ORDERS_ONGOING,arguments: true);
                          },
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: AppThemeDataService.PrimaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(FontAwesomeIcons.play,color: Colors.white,size: 15,),
                              )),
                          title: Text('${S.of(context).ongoingOrders}'),
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
                            Navigator.of(context)
                                .pushNamed(OrdersRoutes.ORDERS);
                          },
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: AppThemeDataService.PrimaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(FontAwesomeIcons.boxes,color: Colors.white,size: 15,),
                              )),
                          title: Text('${S.of(context).orders}'),
                          trailing: Container(
                              decoration: BoxDecoration(
                                  color: StyleText.geyApp,
                                  borderRadius: BorderRadius.circular(8)),

                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(Icons.arrow_forward),
                              )),

                        ),
                      ],
                    ),
                  )

                ]),
            isLoggedIn ? Container() : ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    AuthorizationRoutes.LOGIN_SCREEN,
                        (route) => false);
              },
              leading: Container(
                  decoration: BoxDecoration(
                      color: AppThemeDataService.PrimaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.login_outlined,color: Colors.white,),
                  )),
              title: Text('${S.of(context).login}'),
              trailing: Container(
                  decoration: BoxDecoration(
                      color: StyleText.geyApp,
                      borderRadius: BorderRadius.circular(8)),

                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(Icons.arrow_forward),
                  )),
            ),
            isLoggedIn ?  ListTile(
              onTap: () {
                Navigator.pushNamed(context, MyNotificationsRoutes.MY_NOTIFICATIONS);
              },
              leading: Container(
                  decoration: BoxDecoration(
                      color: AppThemeDataService.PrimaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.notifications,color: Colors.white,),
                  )),
              title: Text('${S.of(context).notifications}'),
              trailing: Container(
                  decoration: BoxDecoration(
                      color: StyleText.geyApp,
                      borderRadius: BorderRadius.circular(8)),

                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(Icons.arrow_forward),
                  )),
            ) : Container() ,
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
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
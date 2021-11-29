import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/categories_routes.dart';
import 'package:mandob_moshtarayat/module_orders/orders_module.dart';
import 'package:mandob_moshtarayat/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/stores_routes.dart';
import 'package:mandob_moshtarayat/module_settings/setting_routes.dart';
import 'package:mandob_moshtarayat/module_stores/stores_routes.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

class MenuScreen extends StatelessWidget {
  final StoreProfileModel profileModel;
  final bool isLoggedIn;
  MenuScreen( this.profileModel, this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: SingleChildScrollView(
        physics:
        BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(height: 25,),
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
              isLoggedIn ?Container(): ListTile(
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
//              customExpansionTile(
//                  title: S.current.orders,
//                  icon: FontAwesomeIcons.box,
//                  children: [
//                    customListTile(getIt<OrdersModule>().myOrdersScreen,
//                        S.current.orderPending, FontAwesomeIcons.solidClock, true),

//                    customListTile(getIt<OrdersModule>().onGoingOrdersScreen,
//                        S.current.ongoingOrders, FontAwesomeIcons.play, true),

//                    customListTile(getIt<OrdersModule>().ordersWithoutPendingScreen,
//                        S.current.orders, FontAwesomeIcons.boxes, true),
//                  ],
//                  page: widget.currentPage),
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
//              ListTile(
//                onTap: () {
//                  // String url = 'https://yes_delivery-app.web.app/tos.html';
//                  // launch(url);
//                },
//                leading: Container(
//                    decoration: BoxDecoration(
//                        color: AppThemeDataService.PrimaryColor,
//                        borderRadius: BorderRadius.circular(8)),
//                    child: Padding(
//                      padding: const EdgeInsets.all(5.0),
//                      child: Icon(Icons.supervised_user_circle,color: Colors.white,),
//                    )),
//                title: Text('${S.of(context).termsOfService}'),
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
//              ListTile(
//                onTap: () {
//                  // String url = 'https://yes_delivery-app.web.app/privacy.html';
//                  // launch(url);
//                },
//                leading: Container(
//                    decoration: BoxDecoration(
//                        color: AppThemeDataService.PrimaryColor,
//                        borderRadius: BorderRadius.circular(8)),
//                    child: Padding(
//                      padding: const EdgeInsets.all(5.0),
//                      child: Icon(Icons.privacy_tip,color: Colors.white,),
//                    )),
//                title: Text('${S.of(context).privacyPolicy}'),
//                trailing: Container(
//                    decoration: BoxDecoration(
//                        color: StyleText.geyApp,
//                        borderRadius: BorderRadius.circular(8)),
//
//                    child: Padding(
//                      padding: const EdgeInsets.all(3.0),
//                      child: Icon(Icons.arrow_forward),
//                    )),
//              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).disabledColor,
                    fontWeight: FontWeight.w500),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Yes Soft | Mandob Store'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
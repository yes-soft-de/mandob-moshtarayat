import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/stores_routes.dart';
import 'package:mandob_moshtarayat/module_settings/setting_routes.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';

class MenuScreen extends StatelessWidget {
  final StoreProfileModel profileModel;
  MenuScreen( this.profileModel);

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
              Container(height: 24,),
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
                      imageSource:'https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png',
                      width: double.maxFinite,
                      height: double.maxFinite,
                    ),
                  ),
                ),
              ),
              Text(profileModel.storeOwnerName),
              Container(
                height: 32,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(StoresRoutes.STORE_INFO);
                },
                leading: Icon(Icons.account_circle_rounded),
                title: Text('${S.of(context).profile}'),
              ),

              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(OrdersRoutes.ORDERS);
                },
                leading: Icon(Icons.history),
                title: Text('${S.of(context).orderLog}'),
              ),
              ListTile(
                onTap: () {
                  // if (screenState.currentState is CaptainOrdersListStateOrdersLoaded){
                  //   screenState.currentState = CaptainOrdersListStateLoading(screenState);
                  //   screenState.getMyOrders();
                  // }
                  Navigator.of(context).pushNamed(SettingRoutes.ROUTE_SETTINGS);
                },
                leading: Icon(Icons.settings),
                title: Text('${S.of(context).settings}'),
              ),
              ListTile(
                onTap: () {
                  // String url = 'https://yes_delivery-app.web.app/tos.html';
                  // launch(url);
                },
                leading: Icon(Icons.supervised_user_circle),
                title: Text('${S.of(context).termsOfService}'),
              ),
              ListTile(
                onTap: () {
                  // String url = 'https://yes_delivery-app.web.app/privacy.html';
                  // launch(url);
                },
                leading: Icon(Icons.privacy_tip),
                title: Text('${S.of(context).privacyPolicy}'),
              ),
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
                  child: Text('Yes Soft | Twaslna Captain'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
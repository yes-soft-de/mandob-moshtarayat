import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/module_profile/ui/screen/store_info_screen.dart';

import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_profile/ui/widget/add_store_widget.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';

class StoreProfileLoadedState extends States {
  final StoreInfoScreenState screenState;
  final StoreProfileModel? profile;
  final String? error;
  final bool empty;

  StoreProfileLoadedState(this.screenState, this.profile,
      {this.error, this.empty = false})
      : super(screenState);
 late LatLng clientAddress;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStore(screenState.model?.id ?? -1);
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStore(screenState.model?.id ?? -1);
          });
    }

//    clientAddress =LatLng(profile!.branches![0].location.lat!.toDouble(), profile!.branches![0].location.lon!.toDouble());
//    clientAddress = LatLng(0, 0);
//    print(clientAddress.latitude);
    return FixedContainer(
        child: CustomListView.custom(children: [
      Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.30,
        child: CustomNetworkImage(
          imageSource: profile?.image.image ?? '',
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.30,
        ),
      ),
      Container(
        width: double.maxFinite,
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16.0, bottom: 16, left: 8, right: 8),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(),
                Text(
                  S.current.storeInfo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Scaffold(
                            appBar: CustomMandopAppBar.appBar(context,
                                title: S.current.updateStore),
                            backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                            body: UpdateStoreWidget(
                              request: CreateStoreRequest(
                                  storeCategoryId: profile!.storeCategoryId,
                                  storeOwnerName: profile!.storeOwnerName,
                                  hasProducts: profile!.hasProducts ? 1 : 0,
                                  privateOrders: profile!.privateOrders ? 1 : 0,
                                  image: profile!.image.image,
                                  phone: profile!.phone,
                                  openingTime:null ,
                                  closingTime:null,
                              ),
                              updateStore:
                                  (name,phone,image,products, privateOrder,open,close,status) {
                                Navigator.of(context).pop();
                                screenState.updateStore(CreateStoreRequest(
                                  status: status,
                                  storeOwnerName: name,
                                  storeCategoryId: profile!.storeCategoryId,
                                  image: image,
                                  hasProducts: products ? 1 : 0,
                                  privateOrders: privateOrder ? 1 : 0,
                                  openingTime: open,
                                  closingTime: close,
                                  phone: phone,
                                  location: GeoJson(lat: 2215,long: 5641)

                                ));
                              },
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
              ],
            ),
          ),
        ),
      ),
//          SizedBox(
//            height: 200,
//            child: FlutterMap(
//              options: MapOptions(
//                center: clientAddress,
//                zoom: 17.0,
//              ),
//              layers: [
//                TileLayerOptions(
//                  urlTemplate: 'https://mt.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
//                  subdomains: ['a', 'b', 'c'],
//                ),
//                MarkerLayerOptions(
//                  markers:  _getMarkers(context),
//                ),
//              ],
//            ),
//          ),
      CustomListTile(
        title: S.current.storeName,
        subTitle: profile?.storeOwnerName,
      ),
      CustomListTile(
        title: S.current.categoryName,
        subTitle: profile?.storeCategoryName,
      ),
      CustomListTile(
        title: S.current.storePhone,
        subTitle: profile?.phone,
      ),
      CustomListTile(
        title: S.current.deliverPrice,
        subTitle:
            '${screenState.model?.deliveryCost.toString() ?? 0} ${S.current.sar}',
      ),
      CustomListTile(
        title: S.current.openingTime,
        subTitle: profile?.openingTime,
      ),
      CustomListTile(
        title: S.current.closingTime,
        subTitle: profile?.closingTime,
      ),
      CustomListTile(title: S.current.products, serve: profile?.hasProducts),
      CustomListTile(
          title: S.current.privateOrder, serve: profile?.privateOrders),

      Container(
        width: double.maxFinite,
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16.0, bottom: 16, left: 8, right: 8),
          child: Text(''),
        ),
      ),
    ]));
  }

  Widget CustomListTile(
      {required String title, String? subTitle, bool? serve}) {
    var context = screenState.context;
    if (serve != null) {
      return Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.symmetric(
                  horizontal: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 1),
                )),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16, left: 8, right: 8),
              child: Text(title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Container(
            width: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Expanded(
              child: Container(
            color: serve ? Colors.green : Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16, left: 8, right: 8),
              child: Center(
                child: Text(
                  serve ? S.current.serve : S.current.notServe,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ))
        ],
      );
    }
    return Flex(
      direction: Axis.horizontal,
      children: [
        Container(
          width: 130,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.symmetric(
                horizontal: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 1),
              )),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16.0, bottom: 16, left: 8, right: 8),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
        ),
        Container(
          width: 4,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        Expanded(
            child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16.0, bottom: 16, left: 8, right: 8),
            child: Text(
              subTitle ?? '',
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ))
      ],
    );
  }

  List<Marker> _getMarkers(BuildContext context) {
    return [
      Marker(
        point: clientAddress,
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 35,
          ),
        ),
      )
    ];
  }
}

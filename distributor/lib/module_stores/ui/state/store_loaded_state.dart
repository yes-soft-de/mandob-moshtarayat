import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/module_profile/ui/screen/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_profile/ui/widget/add_store_widget.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/payment_method.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/spending.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';

class  StoreLoadedState extends States {
  final StoreScreenState screenState;
//  final  ProfileModel? profile;
  final String? error;
  final bool empty;

  StoreLoadedState(this.screenState,
      {this.error, this.empty = false})
      : super(screenState);
 late LatLng clientAddress;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
//          screenState.getStore(screenState.model?.id ?? -1);
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
//            screenState.getStore(screenState.model?.id ?? -1);
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: [
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),

                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.2, 0.7],
                        colors: [
                          Colors.yellow.shade900,
                          Colors.orange.shade900,

//                        Colors.blue[400],
//                        Colors.blue[300],
                        ],
                        // stops: [0.0, 0.1],
                      ),
                    ),

                    height: MediaQuery.of(context).size.height * .30,
                    padding: EdgeInsets.only(top: 20, left: 30, right: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[


                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          S.of(context).totalStore,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          r"150",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
//                Container(
//                  height: MediaQuery.of(context).size.height * .75,
//                  color: Colors.white,
//                ),
                ],
              ),

              Container(
                alignment: Alignment.topCenter,
                padding: new EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .20,
                    right: 20.0,
                    left: 20.0),
                child: new Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GridView(
                    primary: false,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 3.5),
                    ),
                    children: <Widget>[

                      Container(
                        padding: EdgeInsetsDirectional.only(end: 10),
                        child: Spendings(
                          name: S.of(context).thisMonth,
                          amount: r"50",
                        ),
                      ),

                      Container(
                        padding: EdgeInsetsDirectional.only(start: 10),
                        child: Spendings(
                          name: S.of(context).total,
                          amount: r"150",
                        ),
                      ),



                    ],
                  ),
                ),
              ),

              Container(
                alignment: Alignment.topCenter,
                padding: new EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .35,
                    right: 20.0,
                    left: 20.0),
                child: new Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    primary: false,
                    children: <Widget>[

                      PaymentMethods(
                        name: "Stroe one",
                        amount:  "12353535",
                      ),

                      SizedBox(height: 10.0,),
                      PaymentMethods(
                        name: "Stroe one",
                        amount:  "12353535",
                      ),
                      SizedBox(height: 10.0,),
                      PaymentMethods(
                        name: "Stroe one",
                        amount:  "12353535",
                      ),

                      SizedBox(height: 10.0,),

                      PaymentMethods(
                        name: "Stroe one",
                        amount:  "12353535",
                      ),

                      SizedBox(height: 10.0,),
                      PaymentMethods(
                        name: "Stroe one",
                        amount:  "12353535",
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),

    ]));
  }
}

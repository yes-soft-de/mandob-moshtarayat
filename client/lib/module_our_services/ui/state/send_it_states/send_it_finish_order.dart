import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/utils/components/animation_alert.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/client_order/map_client_order.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/screen/send_it_screen.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/send_it_states/send_it_Loaded_state.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/send_it_states/send_it_choose_destination_point.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/send_it_states/send_it_choose_receipt_point.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/send_it_states/send_it_state.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/widget/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/make_order_button.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

class SendItFinishOrderState extends SendItState {
  SendItFinishOrderState(SendItScreenState screenState) : super(screenState);
  final _mapController = MapController();
  TimeOfDay time = TimeOfDay.now();
  var date = DateTime.now();

  @override
  Widget getUI(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        screenState.currentState = SendItLoadedState(screenState);
        screenState.refresh();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar.sendItBar(context,
            title: S.of(context).finishedOrdering, onTap: () {
          screenState.currentState = SendItLoadedState(screenState);
          screenState.refresh();
        }),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.70,
                child: Stack(
                  children: [
                    MapClientOrder(
                      _mapController,
                      onTap: (value) {},
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Padding(
                          padding: EdgeInsets.only(
                              right: 8,
                              left: 8,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.15 +
                                      8),
                          child: CustomAnimationAlert()),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(18))),
                  child: Stack(
                    children: [
                      ListView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: Icon(Icons.location_history),
                                title: Text(S.of(context).myAddress),
                                onTap: () {
                                  screenState.currentState =
                                      SendItChooseReceiptState(screenState);
                                  screenState.refresh();
                                },
                                trailing: Checked(
                                  checked:screenState.receiptPoint != null,
                                  checkedWidget: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green
                                    ),
                                    child: Icon(Icons.check_rounded,color: Colors.white,),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).primaryColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          S.of(context).chooseLocation,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: Icon(Icons.flag_rounded),
                                title: Text(S.of(context).destinationAddress),
                                onTap: () {
                                  screenState.currentState =
                                      SendItChooseDestinationState(screenState);
                                  screenState.refresh();
                                },
                                trailing: Checked(
                                  checked:screenState.destinationPoint != null,
                                  checkedWidget: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green
                                    ),
                                    child: Icon(Icons.check_rounded,color: Colors.white,),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).primaryColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          S.of(context).chooseLocation,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value == null) {
                                    } else {
                                      time = value;
                                      screenState.refresh();
                                    }
                                  });
                                },
                                leading: Icon(
                                  Icons.timer,
                                ),
                                title: Text(S.of(context).orderTime),
                                trailing: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).primaryColor),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        time.format(context).toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 75,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: MakeOrderButton(
                          text: S.of(context).createNewOrder,
                          onPressed: () {
                            if (screenState.receiptPoint == null) {
                              CustomFlushBarHelper.createError(
                                  title: S.of(context).warnning,
                                  message:
                                      S.of(context).pleaseProvideYourAddress)
                                ..show(context);
                            } else if (screenState.destinationPoint == null) {
                              CustomFlushBarHelper.createError(
                                  title: S.of(context).warnning,
                                  message:
                                      S.of(context).pleaseProvidePaymentMethode)
                                ..show(context);
                            } else {
                              screenState.request.destination = GeoJson(
                                  lat: screenState.destinationPoint?.latitude,
                                  long:
                                      screenState.destinationPoint?.longitude);
                              screenState.request.source = GeoJson(
                                  lat: screenState.receiptPoint?.latitude,
                                  long: screenState.receiptPoint?.longitude);
                              screenState.request.deliveryDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      time.hour,
                                      time.minute)
                                  .toUtc()
                                  .toIso8601String();
                              screenState.postClientOrder();
                            }
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

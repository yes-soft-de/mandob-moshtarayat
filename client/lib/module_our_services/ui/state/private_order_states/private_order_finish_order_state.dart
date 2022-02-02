import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/utils/components/animation_alert.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/client_order/map_client_order.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/screen/private_order_screen.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/private_order_states/private_order_Loaded_state.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/private_order_states/private_order_state.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/make_order_button.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

class PrivateFinishOrderStateState extends PrivateOrderState {
  final LatLng? clientAddress;

  PrivateFinishOrderStateState(
      PrivateOrderScreenState screenState, this.clientAddress)
      : super(screenState) {
    clientLocation = this.clientAddress;
  }
  final _mapController = MapController();
  TextEditingController noteController = TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  var date = DateTime.now();
  String? payments;
  LatLng? clientLocation;

  @override
  Widget getUI(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        screenState.currentState = PrivateOrderLoadedState(screenState);
        screenState.refresh();
        return false;
      },
      child: Stack(
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
                    onTap: (newPos) {
                      clientLocation = newPos;
                      screenState.refresh();
                    },
                    myPos: clientAddress,
                    defaultPoint: clientAddress,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                        padding: EdgeInsets.only(
                            right: 8,
                            left: 8,
                            bottom:
                                MediaQuery.of(context).size.height * 0.15 + 8),
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
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: Icon(
                                payments != 'cash'
                                    ? Icons.payment
                                    : FontAwesomeIcons.coins,
                              ),
                              title: Text(S.of(context).paymentMethod),
                              trailing: DropdownButton(
                                  value: payments,
                                  underline: Container(),
                                  icon: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.arrow_drop_down_rounded),
                                  ),
                                  hint: Text(S.of(context).paymentMethodHint),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(S.of(context).card),
                                      value: 'card',
                                    ),
                                    DropdownMenuItem(
                                      child: Text(S.of(context).cash),
                                      value: 'cash',
                                    ),
                                  ],
                                  onChanged: (payment) {
                                    payments = payment.toString();
                                    screenState.refresh();
                                  }),
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
                          if (clientLocation == null) {
                            CustomFlushBarHelper.createError(
                                title: S.of(context).warnning,
                                message: S.of(context).pleaseProvideYourAddress)
                              ..show(context);
                          } else if (payments == null) {
                            CustomFlushBarHelper.createError(
                                title: S.of(context).warnning,
                                message:
                                    S.of(context).pleaseProvidePaymentMethode)
                              ..show(context);
                          } else {
                            screenState.request.payment = payments;
                            screenState.request.destination = GeoJson(
                                long: clientLocation?.longitude,
                                lat: clientLocation?.latitude);
                            screenState.request.deliveryDate = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute)
                                .toUtc()
                                .toIso8601String();
                            screenState.postPrivateOrder();
                          }
                        },
                      ),
                    ),
                  ],
                )),
          ),
          SafeArea(
            top: true,
            child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      screenState.currentState =
                          PrivateOrderLoadedState(screenState);
                      screenState.refresh();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

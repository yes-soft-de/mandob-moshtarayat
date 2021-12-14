import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/client_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/client_order/client_order_state.dart';
import 'package:mandob_moshtarayat/utils/components/animation_alert.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/client_order/map_client_order.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/client_order/pop_up_button.dart';
import 'package:mandob_moshtarayat/module_stores/model/checkout_model.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/components/make_order_button.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

class ClientOrderLoadedState extends ClientOrderState {
  ClientOrderLoadedState(ClientOrderScreenState screenState)
      : super(screenState);
  final _mapController = MapController();
  TextEditingController noteController = TextEditingController();
  LatLng? clientAddress;
  bool flagMyPos = true;
  TimeOfDay time = TimeOfDay.now();
  var date = DateTime.now();
  String? payments;
  late CheckoutModel checkoutModel;

  @override
  Widget getUI(BuildContext context) {
    if (flagMyPos && screenState.myPos != null) {
      clientAddress = screenState.myPos;
      _mapController.move(screenState.myPos!, 17);
      flagMyPos = false;
    }
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is CheckoutModel) {
      checkoutModel = args;
    }
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: Stack(
              children: [
                MapClientOrder(
                  _mapController,
                  onTap: (newPos) {
                    clientAddress = newPos;
                    screenState.refresh();
                  },
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
                      const BorderRadius.vertical(top: Radius.circular(18))),
              child: Stack(
                children: [
                  ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      const SizedBox(
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
                            leading: const Icon(
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
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                                icon: const Padding(
                                  padding: EdgeInsets.all(4.0),
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
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: CustomFormField(
                          contentPadding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          preIcon: const Icon(Icons.sticky_note_2_rounded),
                          hintText: S.of(context).note,
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 75,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MakeOrderButton(
                      text: S.of(context).createNewOrder,
                      onPressed: () {
                        if (clientAddress == null) {
                          CustomFlushBarHelper.createError(
                              title: S.of(context).warnning,
                              message: S.of(context).pleaseProvideYourAddress)
                            .show(context);
                        } else if (payments == null) {
                          CustomFlushBarHelper.createError(
                              title: S.of(context).warnning,
                              message:
                                  S.of(context).pleaseProvidePaymentMethode)
                            .show(context);
                        } else {
                          screenState.postClientOrder(ClientOrderRequest(
                              destination: GeoJson(
                                  lat: clientAddress?.latitude,
                                  long: clientAddress?.longitude),
                              payment: payments,
                              ownerID: null,
                              deliveryCost: checkoutModel.deliveryCost,
                              orderCost: checkoutModel.orderCost,
                              deliveryDate: DateTime(date.year, date.month,
                                      date.day, time.hour, time.minute)
                                  .toUtc()
                                  .toIso8601String(),
                              note: noteController.text,
                              products: checkoutModel.cart));
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
              alignment: AlignmentDirectional.topStart, child: PopUpButton()),
        ),
      ],
    );
  }
}

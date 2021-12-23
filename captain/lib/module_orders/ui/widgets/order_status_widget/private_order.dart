import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat_captain/consts/order_status.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_chat/chat_routes.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/order_details_model.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:mandob_moshtarayat_captain/module_orders/util/whatsapp_link_helper.dart';
import 'package:mandob_moshtarayat_captain/module_orders/utils/icon_helper/order_progression_helper.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/custom_flushbar.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivateOrder extends StatelessWidget {
  final TextEditingController distanceCalculator;
  final StoreOwnerInfo storeInfo;
  final OrderInfo orderInfo;
  final Function() acceptOrder;
  final Function(String) provideDistance;
  final String orderNumber;

  PrivateOrder(
      {required this.distanceCalculator,
      required this.storeInfo,
      required this.orderInfo,
      required this.acceptOrder,
      required this.provideDistance,
      required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        // order info with store info
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).backgroundColor.withOpacity(0.7),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      Text(S.of(context).orderNumber,
                          style: TextStyle(fontSize: 14)),
                      Container(
                        height: 4,
                      ),
                      Text(
                        '$orderNumber',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).disabledColor),
                      ),
                    ],
                  ),
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      Text(S.of(context).storeName,
                          style: TextStyle(fontSize: 14)),
                      Container(
                        height: 4,
                      ),
                      Text(
                        storeInfo.storeOwnerName,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).disabledColor),
                      ),
                    ],
                  ),
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      Text(S.of(context).branch,
                          style: TextStyle(fontSize: 14)),
                      Container(
                        height: 4,
                      ),
                      Text(
                        S.current.defaultBranch,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).disabledColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // tile for titling cart
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListTile(
            leading: Icon(
              FontAwesomeIcons.solidStar,
              color: Theme.of(context).disabledColor,
              size: 22,
            ),
            title: Text(
              S.of(context).privateOrder,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        // detail
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(S.current.orderDetails),
            ),
            subtitle: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  orderInfo.orderDetails ?? '',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ),
        // note
        orderInfo.note != null
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(S.current.note),
                  ),
                  subtitle: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        orderInfo.note ?? '',
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        // command choice tile
        Padding(
          padding: const EdgeInsets.all(16),
          child: ListTile(
            leading: Icon(
              Icons.bubble_chart_rounded,
              color: Theme.of(context).disabledColor,
              size: 25,
            ),
            title: Text(
              S.of(context).captain,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        // To Progress the Order
        _getNextStageCard(context),
        Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 24.0),
          child: Divider(
            thickness: 2.5,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        // To Chat with client in app
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.of(context).pushNamed(
                ChatRoutes.chatRoute,
                arguments: orderInfo.roomID,
              );
            },
            child: CommunicationCard(
              text: S.of(context).chatWithStoreOwner,
              color: Theme.of(context).primaryColor,
              image: Icon(
                Icons.chat_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 24.0),
          child: Divider(
            thickness: 2.5,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        storeInfo.phone != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    var url =
                        WhatsAppLinkHelper.getWhatsAppLink(storeInfo.phone!);
                    launch(url);
                  },
                  child: CommunicationCard(
                    color: Colors.green,
                    text: S.of(context).whatsappWithStoreOwner,
                    image: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              )
            : Container(),
        storeInfo.branchLocation != null
            ? Padding(
                padding: const EdgeInsets.only(right: 24.0, left: 24.0),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).backgroundColor,
                ),
              )
            : Container(),
        // To Open Maps
        storeInfo.branchLocation != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    var url = WhatsAppLinkHelper.getMapsLink(
                        storeInfo.branchLocation?.lat ?? 0,
                        storeInfo.branchLocation?.long ?? 0);
                    launch(url);
                  },
                  child: CommunicationCard(
                    color: Colors.blue[900],
                    text: S.of(context).storeLocation +
                        (storeInfo.branchDestance != null
                            ? ' ( ${storeInfo.branchDestance} ${S.current.km} ) '
                            : ''),
                    image: Icon(
                      Icons.store_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              )
            : Container(),
        storeInfo.branchLocation != null
            ? Padding(
                padding: const EdgeInsets.only(right: 24.0, left: 24.0),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).backgroundColor,
                ),
              )
            : Container(),
        orderInfo.destination != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    var url = WhatsAppLinkHelper.getMapsLink(
                        orderInfo.destination?.lat ?? 0,
                        orderInfo.destination?.long ?? 0);
                    launch(url);
                  },
                  child: CommunicationCard(
                    color: Colors.red[900],
                    text: S.of(context).locationOfCustomer +
                        (orderInfo.destination != null
                            ? ' ( ${orderInfo.recieveDistanceValue} ${S.current.km} ) '
                            : ''),
                    image: Icon(Icons.location_history, color: Colors.white),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _getNextStageCard(BuildContext context) {
    if (orderInfo.state == OrderStatus.FINISHED) {
      return Container();
    } else if (orderInfo.state == OrderStatus.DELIVERING) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 72,
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                          controller: distanceCalculator,
                          decoration: InputDecoration(
                            hintText:
                                '${S.of(context).finishOrderProvideDistanceInKm} e.g 45',
                            prefixIcon: Icon(Icons.add_road),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                          onEditingComplete: () =>
                              FocusScope.of(context).unfocus(),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9+.]')),
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[700],
                    ),
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (distanceCalculator.text.isNotEmpty) {
                            provideDistance(distanceCalculator.text);
                          } else {
                            CustomFlushBarHelper.createError(
                                    title: S.current.warnning,
                                    message:
                                        S.of(context).pleaseProvideTheDistance)
                                .show(context);
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            acceptOrder();
          },
          child: CommunicationCard(
            text: OrderProgressionHelper.getNextStageHelper(
              orderInfo.state,
              orderInfo.payment.toLowerCase().contains('ca'),
              context,
            ),
            color: Colors.green[700],
            image: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      );
    }
  }
}

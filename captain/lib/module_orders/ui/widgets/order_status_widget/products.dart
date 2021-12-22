import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mandob_moshtarayat_captain/consts/order_status.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_chat/chat_routes.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/order_details_model.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/widgets/order_widget/bill.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/widgets/order_widget/order_chip.dart';
import 'package:mandob_moshtarayat_captain/module_orders/util/whatsapp_link_helper.dart';
import 'package:mandob_moshtarayat_captain/module_orders/utils/icon_helper/order_progression_helper.dart';
import 'package:mandob_moshtarayat_captain/utils/components/hider.dart';
import 'package:mandob_moshtarayat_captain/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/order_status_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductsOrder extends StatelessWidget {
  final TextEditingController distanceCalculator;
  final List<StoreOwnerInfo> cart;
  final OrderInfo orderInfo;
  final Function() acceptOrder;
  final Function(String) provideDistance;
  final Function(StoreOwnerInfo) onStore;
  final String orderNumber;

  ProductsOrder(
      {required this.distanceCalculator,
      required this.onStore,
      required this.cart,
      required this.orderInfo,
      required this.acceptOrder,
      required this.provideDistance,
      required this.orderNumber});
  bool canChangeState = false;
  int storeDoneStates = 0;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        // tile for titling cart
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListTile(
            leading: Icon(
              Icons.shopping_cart_rounded,
              color: Theme.of(context).disabledColor,
              size: 25,
            ),
            title: Text(
              S.of(context).orderList,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        // cart
        getOrdersList(cart, context),
        // expected order bill tile
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListTile(
            leading: Icon(
              Icons.sticky_note_2_rounded,
              color: Theme.of(context).disabledColor,
              size: 25,
            ),
            title: Text(
              S.of(context).expectedOrderBill,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        // expected order bill
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: BillCard(
            id: orderNumber,
            deliveryCost: orderInfo.deliveryCost,
            orderCost: orderInfo.orderCost,
          ),
        ),
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
        Hider(
            active: orderInfo.state == OrderStatus.WAITING || canChangeState,
            child: _getNextStageCard(context)),
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
              text: S.of(context).chatWithClient,
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

  Widget getOrdersList(List<StoreOwnerInfo> carts, BuildContext context) {
    List<Widget> orderChips = [];
    storeDoneStates = 0;
    carts.forEach((element) {
      if (element.state == OrderStatus.DELIVERING) storeDoneStates += 1;
      orderChips.add(InkWell(
        onTap: orderInfo.state != OrderStatus.WAITING
            ? () {
                onStore(element);
              }
            : null,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: orderInfo.state != OrderStatus.WAITING
                  ? StatusHelper.getOrderStatusColor(element.state)
                  : Theme.of(context).backgroundColor),
          child: ListTile(
            leading: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: CustomNetworkImage(
                    height: 40,
                    imageSource: element.image,
                    width: 40,
                  ),
                )),
            trailing: Hider(
              active: orderInfo.state != OrderStatus.WAITING,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: StatusHelper.getOrderStatusColor(element.state)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: StatusHelper.getOrderStatusColor(
                                element.state),
                          ),
                        )),
                  )),
            ),
            title: Text(
              element.storeOwnerName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: element.state != OrderStatus.WAITING
                      ? Colors.white
                      : null),
            ),
            subtitle: orderInfo.state != OrderStatus.WAITING
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                        StatusHelper.getOrderStatusDescriptionMessages(
                            element.state),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white70)),
                  )
                : null,
          ),
        ),
      ));
      if (orderInfo.state == OrderStatus.WAITING || cart.length == 1) {
        int i = 0;
        element.items.forEach((item) {
          i += 1;
          orderChips.add(OrderChip(
            productID: item.productID,
            title: item.productName,
            image: item.productImage,
            price: item.productPrice,
            currency: S.current.sar,
            defaultQuantity: item.countProduct,
          ));
          if (element.items.length - 1 == i) {
            orderChips.add(Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 8.0, top: 8.0, bottom: 8.0),
              child: DottedLine(
                dashColor: Theme.of(context).backgroundColor,
                lineThickness: 2.5,
                dashLength: 6,
              ),
            ));
          }
        });
      }
      orderChips.add(Padding(
        padding:
            const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0, bottom: 8.0),
        child: DottedLine(
          dashColor: Theme.of(context).backgroundColor,
          lineThickness: 2.5,
          dashLength: 6,
        ),
      ));
    });
    if (storeDoneStates == carts.length) {
      canChangeState = true;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 16),
      child: Flex(
        direction: Axis.vertical,
        children: orderChips,
      ),
    );
  }
}

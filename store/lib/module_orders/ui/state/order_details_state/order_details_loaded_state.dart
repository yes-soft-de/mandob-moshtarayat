import 'package:dotted_line/dotted_line.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/consts/order_status.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_chat/chat_routes.dart';
import 'package:mandob_moshtarayat/module_chat/model/chat_argument.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_details_model.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_details_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/order_details/bill.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/order_details/order_chip.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/helpers/order_status_helper.dart';
import 'package:mandob_moshtarayat/utils/helpers/translating.dart';

class OrderDetailsLoadedState extends OrderDetailsState {
  OrderDetailsScreenState screenState;
  OrderDetailsModel orderDetails;

  OrderDetailsLoadedState(this.screenState, this.orderDetails)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FixedContainer(
      child: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          //store image
//          Hider(
//            active: orderDetails.orderType != 3,
//            child: Padding(
//              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//              child: CustomNetworkImage(
//                imageSource: orderDetails.storeInfo.image,
//                height: height * 0.3,
//                width: width,
//              ),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Center(
//              child: Text(
//                '${orderDetails.orderType != 3 ? orderDetails.storeInfo.storeOwnerName : S.current.deliverForMe}',
//                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//              ),
//            ),
//          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: StatusHelper.getOrderStatusColor(orderDetails.state)),
              child: ListTile(
                title: Text(
                  S.of(context).orderStatus,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                subtitle: Text(
                  StatusHelper.getOrderStatusMessages(orderDetails.state),
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text(orderDetails.createdAt,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                leading: Icon(
                  StatusHelper.getOrderStatusIcon(orderDetails.state),
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
          Hider(
            active: true,
//                orderDetails.order.createdAt != orderDetails.order.deliveryDate,
            child: Column(
              children: [
//                ListTile(
//                  shape: RoundedRectangleBorder(
//                      borderRadius:
//                          BorderRadius.vertical(top: Radius.circular(25))),
//                  leading: Container(
//                      height: double.maxFinite,
//                      width: 50,
//                      child: Icon(
//                        FontAwesomeIcons.solidClock,
//                        color: Colors.white,
//                      )),
//                  tileColor: Theme.of(context).primaryColor,
//                  title: Text(
//                    S.current.deliveryTime,
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold, color: Colors.white),
//                  ),
//                  subtitle: Text(
//                    Trans.localString(orderDetails.order.deliveryDate, context),
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold, color: Colors.white),
//                  ),
//                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    leading: Container(
                        height: double.maxFinite,
                        width: 50,
                        child: Icon(
                          FontAwesomeIcons.delicious,
                          color: Colors.white,
                        )),
                    tileColor: Theme.of(context).primaryColor,
                    title: Text(
                      S.current.orderTime,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    subtitle: Text(
                      Trans.localString(orderDetails.createdAt, context),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          orderDetails.roomID.isNotEmpty && orderDetails.state !=
              OrderStatusEnum.WAITING
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).primaryColor),
                    child: ListTile(
                      onTap: () {
                        print(orderDetails.roomID);
                        Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                            arguments: ChatArgument(
                              roomID:orderDetails.roomID,
                              userType:'captain',
                              userID:int.parse(orderDetails.captainID),
                            ));
                      },
                      title: Text(
                        S.of(context).chatWithCaptain,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      subtitle: Text(
                        S.of(context).openChatRoom,
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: Icon(
                        Icons.sms,
                        color: Colors.white,
                        size: 35,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          getOrderTypeWidget(orderDetails.orderType),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  Widget getOrderTypeWidget(int orderType) {
    var context = screenState.context;
//    String note = orderDetails.order.note ?? '';
    if (orderType == 1) {
      return Flex(
        direction: Axis.vertical,
        children: [
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
          ListView(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            children: getOrdersList(orderDetails.carts),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BillCard(
              id: screenState.orderNumber!,
//              deliveryCost: orderDetails.order.deliveryCost,
              orderCost: getTotal(orderDetails.carts),
            ),
          )
        ],
      );
    } else if (orderType == 2) {
      return Flex(
        direction: Axis.vertical,
        children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(S.current.orderDetails),
            ),
            subtitle: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(screenState.context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  orderDetails.orderDetails,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          orderDetails.note.isNotEmpty
              ? ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(S.current.note),
                  ),
                  subtitle: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(screenState.context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        orderDetails.note,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      );
    } else if (orderType == 3) {
      return Flex(
        direction: Axis.vertical,
        children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(S.current.orderDetails),
            ),
            subtitle: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(screenState.context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  orderDetails.orderDetails,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          orderDetails.note.isNotEmpty
              ? ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(S.current.note),
                  ),
                  subtitle: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(screenState.context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        orderDetails.note,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                )
              : Container(),
//          ListTile(
//            title: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text(S.current.recipientName),
//            ),
//            subtitle: Container(
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(10),
//                color: Theme.of(screenState.context).backgroundColor,
//              ),
//              child: Padding(
//                padding: const EdgeInsets.all(16.0),
//                child: Text(
//                  orderDetails.order.recipientName ?? '',
//                  textAlign: TextAlign.start,
//                ),
//              ),
//            ),
//          ),
//          ListTile(
//            title: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text(S.current.recipientPhoneNumber),
//            ),
//            subtitle: Container(
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(10),
//                color: Theme.of(screenState.context).backgroundColor,
//              ),
//              child: Padding(
//                padding: const EdgeInsets.all(16.0),
//                child: Text(
//                  orderDetails.order.recipientPhoneNumber ?? '',
//                  textAlign: TextAlign.start,
//                ),
//              ),
//            ),
//          ),
        ],
      );
    }
    return Container();
  }

  List<Widget> getOrdersList(List<Item> carts) {
    List<Widget> orderChips = [];
    carts.forEach((element) {
      orderChips.add(OrderChip(
        productID: element.productID,
        title: element.productName,
        image: element.productImage,
        price: element.productPrice,
        currency: S.current.sar,
        editable: false,
        defaultQuantity: element.countProduct,
      ));
      orderChips.add(Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: DottedLine(
          dashColor: Theme.of(screenState.context).backgroundColor,
          lineThickness: 2.5,
          dashLength: 6,
        ),
      ));
    });
    return orderChips;
  }

  double getTotal(List<Item> items) {
    var total = 0.0;
    for (var element in items) {
      total = total + (element.countProduct * element.productPrice);
    }
    return total;
  }
}

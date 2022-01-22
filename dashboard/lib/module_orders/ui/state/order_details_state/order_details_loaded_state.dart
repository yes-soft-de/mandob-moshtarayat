import 'package:dotted_line/dotted_line.dart';
import 'package:mandob_moshtarayat_dashboad/consts/order_status.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_chat/chat_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_main/main_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/model/order_details_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_details_response/invoice.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/screen/order_details_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/state/order_details_state/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/widget/invoice.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/widget/order_details/bill.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/widget/order_details/order_chip.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/widget/order_details/order_details_title_bar.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/stores_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/stores_routes.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/order_status_helper.dart';

class OrderDetailsLoadedState extends OrderDetailsState {
  OrderDetailsScreenState screenState;
  OrderDetailsModel orderDetails;

  OrderDetailsLoadedState(this.screenState, this.orderDetails)
      : super(screenState);

  bool get edit => screenState.edit;

  @override
  Widget getUI(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        await Navigator.of(context).pushNamedAndRemoveUntil(
            MainRoutes.MAIN_SCREEN, (route) => false,
            arguments: 1);
        return !edit;
      },
      child: FixedContainer(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              orderDetails.order.orderType != 3 &&
                      orderDetails.order.orderType != 1
                  ? SizedBox(
                      height: height / 2,
                      width: width,
                      child: CustomNetworkImage(
                        imageSource: orderDetails.carts.first.image,
                        height: height / 2,
                        width: width,
                      ),
                    )
                  : const SizedBox(),
              orderDetails.order.orderType != 3 &&
                      orderDetails.order.orderType != 1
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: OrderDetailsTitleBar(
                        title: orderDetails.carts.first.storeOwnerName,
                        rate: 0,
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(
                    right: 12.0, left: 12.0, bottom: 25.0, top: 25.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    '${S.of(context).orderNumber} #${screenState.orderNumber}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Hider(active: false, child: getBills()),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: StatusHelper.getOrderStatusColor(
                          orderDetails.order.state)),
                  child: ListTile(
                    title: Text(
                      S.of(context).orderStatus,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      StatusHelper.getOrderStatusMessages(
                          orderDetails.order.state),
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: Icon(
                      StatusHelper.getOrderStatusIcon(orderDetails.order.state),
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
              Hider(
                active: false,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                            arguments: orderDetails.order.roomID);
                      },
                      title: Text(
                        S.of(context).chatWithClient,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      subtitle: Text(
                        S.of(context).openChatRoom,
                        style: const TextStyle(color: Colors.white),
                      ),
                      leading: const Icon(
                        Icons.sms,
                        color: Colors.white,
                        size: 35,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              getOrderTypeWidget(orderDetails.order.orderType),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getOrderTypeWidget(int orderType) {
    var context = screenState.context;
    String note = orderDetails.order.note ?? '';
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Column(
            children: getOrdersList(orderDetails.carts),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BillCard(
              id: screenState.orderNumber!,
              deliveryCost: orderDetails.order.deliveryCost,
              orderCost: orderDetails.order.orderCost,
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
                  orderDetails.order.orderDetails ?? '',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          note.isNotEmpty
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
                        orderDetails.order.note ?? '',
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
                  orderDetails.order.orderDetails ?? '',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          note.isNotEmpty
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
                        orderDetails.order.note ?? '',
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                )
              : Container(),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(S.current.recipientName),
            ),
            subtitle: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(screenState.context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  orderDetails.order.recipientName ?? '',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(S.current.recipientPhoneNumber),
            ),
            subtitle: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(screenState.context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  orderDetails.order.recipientPhoneNumber ?? '',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget getBills() {
    List<Widget> widgets = [];
    for (var element in orderDetails.carts) {
      if (element.invoiceAmount != null && element.invoiceImage != null) {
        widgets.add(CustomInvoiceAlert(
          image: element.invoiceImage ?? '',
          cost: element.invoiceAmount?.toStringAsFixed(1) ?? '',
        ));
      }
    }
    return Column(
      children: widgets,
    );
  }

  List<Widget> getOrdersList(List<StoreOwnerInfo> carts) {
    List<Widget> orderChips = [];
    carts.forEach((element) {
      orderChips.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(screenState.context).backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: ClipOval(
                child: CustomNetworkImage(
                    height: 45, width: 45, imageSource: element.image),
              ),
              trailing: const Icon(Icons.arrow_forward_rounded),
              onTap: () {
                Navigator.of(screenState.context).pushNamed(
                    StoresRoutes.STORE_INFO,
                    arguments: StoresModel(
                        id: element.storeOwnerID,
                        storeOwnerName: element.storeOwnerName,
                        categoryId: '',
                        deliveryCost: 0,
                        hasProducts: false,
                        image: '',
                        phone: '',
                        privateOrders: false,
                        status: '',
                        stcPay: '',
                        bankName: '',
                        bankNumber: ''));
              },
              title: Text(element.storeOwnerName),
            ),
          ),
        ),
      );
      element.items.forEach((element) {
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
      orderChips.add(const SizedBox(
        height: 16,
      ));
      orderChips.add(Hider(
          active: element.invoiceAmount != null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomInvoiceAlert(
              image: element.invoiceImage.toString(),
              cost: element.invoiceAmount.toString(),
            ),
          )));
    });
    return orderChips;
  }
}

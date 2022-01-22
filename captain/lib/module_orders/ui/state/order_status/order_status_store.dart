import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat_captain/consts/order_status.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_chat/chat_routes.dart';
import 'package:mandob_moshtarayat_captain/module_chat/model/chat_argument.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/order_details_model.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/update_store_order_status_request.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/widgets/order_widget/custom_step.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/widgets/order_widget/invoice_dialog.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/widgets/order_widget/order_chip.dart';
import 'package:mandob_moshtarayat_captain/module_orders/util/whatsapp_link_helper.dart';
import 'package:mandob_moshtarayat_captain/module_orders/utils/icon_helper/order_progression_helper.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/order_status_helper.dart';
import 'package:mandob_moshtarayat_captain/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsStoreLoaded extends OrderDetailsState {
  final OrderStatusScreenState screenState;
  StoreOwnerInfo storeOwnerInfo;
  OrderDetailsStoreLoaded(this.screenState, this.storeOwnerInfo)
      : super(screenState) {
    if (storeOwnerInfo.state == OrderStatus.IN_STORE) {
      makeInvoice = true;
    }
  }
  bool makeInvoice = false;
  @override
  Widget getUI(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        screenState.getOrderDetails(int.parse(screenState.orderId ?? '-1'));
        return false;
      },
      child: Scaffold(
        appBar: CustomTwaslnaAppBar.appBar(context,
            title: storeOwnerInfo.storeOwnerName, onTap: () {
          screenState.getOrderDetails(int.parse(screenState.orderId ?? '-1'));
        }),
        body: CustomListView.custom(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 16,
                right: 16,
              ),
              child: OrderProgressionHelper.getStatusIcon(
                  storeOwnerInfo.state, 175, context),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 16, right: 16, bottom: 8),
              child: Flex(
                direction: Axis.horizontal,
                children: getStepper(
                    StatusHelper.getOrderStatusIndex(storeOwnerInfo.state)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 8, bottom: 24, top: 16),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: StatusHelper.getOrderStatusColor(
                          storeOwnerInfo.state)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      StatusHelper.getOrderStatusIcon(storeOwnerInfo.state),
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      StatusHelper.getOrderStatusDescriptionMessages(
                          storeOwnerInfo.state),
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ),

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
                  S.of(context).products,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            // with order type we can get order widgets
            getOrdersList(storeOwnerInfo.items, context),
            _getNextStageCard(context),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0),
              child: Divider(
                thickness: 2.5,
                color: Theme.of(context).backgroundColor,
              ),
            ),
            // To Chat with store in app
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ChatRoutes.chatRoute,
                    arguments: ChatArgument(
                        roomID: storeOwnerInfo.roomID,
                        userType: 'store',
                        userID: storeOwnerInfo.storeOwnerID),
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
            storeOwnerInfo.phone != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        var url = WhatsAppLinkHelper.getWhatsAppLink(
                            storeOwnerInfo.phone!);
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
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0),
              child: Divider(
                thickness: 2.5,
                color: Theme.of(context).backgroundColor,
              ),
            ),
            // To Open Maps
            storeOwnerInfo.branchLocation != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        var url = WhatsAppLinkHelper.getMapsLink(
                            storeOwnerInfo.branchLocation?.lat ?? 0,
                            storeOwnerInfo.branchLocation?.long ?? 0);
                        launch(url);
                      },
                      child: CommunicationCard(
                        color: Colors.blue[900],
                        text: S.of(context).storeLocation +
                            (storeOwnerInfo.branchDestance != null
                                ? ' ( ${storeOwnerInfo.branchDestance} ${S.current.km} ) '
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
            Container(
              height: 75,
            ),
          ],
        ),
        floatingActionButton: makeInvoice
            ? TweenAnimationBuilder(
                duration: Duration(milliseconds: 750),
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.linear,
                builder: (context, double val, child) {
                  return Transform.scale(
                    scale: val,
                    child: child,
                  );
                },
                child: ElevatedButton(
                  onPressed: detectInvoice,
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.current.makeBill,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }

  List<Widget> getStepper(int currentIndex) {
    List<Widget> steps = [
      CustomStepForStore(
          status: OrderStatus.GOT_CAPTAIN, currentIndex: currentIndex),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Opacity(
            opacity: 0.65,
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex <
                        StatusHelper.getOrderStatusIndex(OrderStatus.IN_STORE)
                    ? Theme.of(screenState.context).disabledColor
                    : Theme.of(screenState.context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      CustomStepForStore(
          status: OrderStatus.IN_STORE, currentIndex: currentIndex),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Opacity(
            opacity: 0.65,
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex <
                        StatusHelper.getOrderStatusIndex(OrderStatus.DELIVERING)
                    ? Theme.of(screenState.context).disabledColor
                    : Theme.of(screenState.context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      CustomStepForStore(
          status: OrderStatus.DELIVERING, currentIndex: currentIndex),
    ];
    return steps;
  }

  Widget getOrdersList(List<Item> carts, BuildContext context) {
    List<Widget> orderChips = [];
    carts.forEach((element) {
      orderChips.add(OrderChip(
        productID: element.productID,
        title: element.productName,
        image: element.productImage,
        price: element.productPrice,
        currency: S.current.sar,
        defaultQuantity: element.countProduct,
      ));
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
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 16),
      child: Flex(
        direction: Axis.vertical,
        children: orderChips,
      ),
    );
  }

  void acceptOrder() {
    screenState.requestStoreOrderProgress(
        UpdateStoreOrderStatusRequest(
            orderNumber: int.parse(screenState.orderId ?? '-1'),
            storeOwnerProfileId: storeOwnerInfo.storeOwnerID,
            state: StatusHelper.getStatusString(OrderStatus.values[
                StatusHelper.getOrderStatusIndex(storeOwnerInfo.state) + 1])),
        StatusHelper.getOrderStatusIndex(storeOwnerInfo.state));
  }

  Widget _getNextStageCard(BuildContext context) {
    if (storeOwnerInfo.state == OrderStatus.GOT_CAPTAIN) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            acceptOrder();
          },
          child: CommunicationCard(
            text: OrderProgressionHelper.getNextStageHelper(
              OrderStatus.GOT_CAPTAIN,
              false,
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
    } else if (storeOwnerInfo.state == OrderStatus.IN_STORE) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            bool invoiceAvailable =
                screenState.invoiceRequest?.storeID.toString() ==
                    storeOwnerInfo.storeOwnerID.toString();
            if (invoiceAvailable) {
              acceptOrder();
            } else {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning,
                      message: S.current.pleaseProvideStoreBill)
                  .show(context);
            }
          },
          child: CommunicationCard(
            text: OrderProgressionHelper.getNextStageHelper(
              OrderStatus.IN_STORE,
              false,
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
    } else {
      return Container();
    }
  }

  Future<void> detectInvoice() async {
    String? imagePath;
    try {
//        imagePath = await EdgeDetection.detectEdge;
      await ImagePicker.platform
          .pickImage(source: ImageSource.camera, imageQuality: 70)
          .then((value) {
        if (value != null) {
          imagePath = value.path;
        }
      });
    } catch (e) {
      Logger().error('Detect Edge', e.toString(), StackTrace.current);
      await CustomFlushBarHelper.createError(
              title: S.current.warnning, message: e.toString())
          .show(screenState.context);
      return;
    }
    if (imagePath != null) {
      final totalCost = TextEditingController();
      await showDialog(
          context: screenState.context,
          barrierDismissible: false,
          builder: (context) {
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 375),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.linear,
              builder: (context, double val, child) {
                return Transform.scale(
                  scale: val,
                  child: child,
                );
              },
              child: InvoiceDialog(
                totalCost,
                imagePath!,
                isBilledCalculated: false,
                onPressed: (isBilled) {
                  Navigator.of(context).pop();
                  screenState.widget.stateManager.uploadBill(
                    screenState,
                    imagePath!,
                    double.tryParse(totalCost.text) ?? 0,
                    isBilled: isBilled,
                    storeID: storeOwnerInfo.storeOwnerID.toString(),
                  );
                },
              ),
            );
          });
    }
  }
}

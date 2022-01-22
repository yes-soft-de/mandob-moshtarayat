import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/consts/order_status.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_details_response/destination.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_details_response/invoice.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_details_response/order.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_details_response/order_detail.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_details_response/order_details_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/order_status_helper.dart';

class OrderDetailsModel extends DataModel {
  List<StoreOwnerInfo> carts = [];
  List<Invoice> invoices = [];
  StoreOwnerInfo storeInfo = StoreOwnerInfo.Empty();
  OrderInfo order = OrderInfo.Empty();
  String? error;
  bool empty = false;
  OrderDetailsModel? orderDetailsModel;

  OrderDetailsModel(
      {required this.carts, required this.order, required this.invoices});

  OrderDetailsModel.Error(this.error);

  OrderDetailsModel.Empty() {
    empty = true;
  }

  bool get isEmpty => empty;

  bool get hasError => error != null;

  OrderDetailsModel.Data(OrderDetailsResponse response) {
    orderDetailsModel = OrderDetailsModel(
      carts: toCartList(response.data?.orderDetails ?? <OrderDetail>[]),
      order: toOrder(response.data?.order),
      invoices: response.data?.invoices ?? [],
    );
  }

  bool get hasData => orderDetailsModel != null;

  OrderDetailsModel get data =>
      orderDetailsModel ?? OrderDetailsModel(carts: carts, order: order,invoices: invoices);
}

class Item {
  int productID;
  String productName;
  String productImage;
  double productPrice;
  int countProduct;
  int storeOwnerProfileID;
  int productCategoryID;
  String orderNumber;

  Item(
      {required this.productID,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.countProduct,
      required this.storeOwnerProfileID,
      required this.productCategoryID,
      required this.orderNumber});
}

class StoreOwnerInfo {
  String storeOwnerName = '';
  int storeOwnerID = -1;
  String image = '';
  String? imageURL;
  bool empty = false;
  num? rating = 0;
  double? invoiceAmount;
  String? invoiceImage;
  late List<Item> items;
  StoreOwnerInfo(
      {required this.storeOwnerName,
      required this.storeOwnerID,
      required this.image,
      this.imageURL,
      this.rating,
      required this.items,
      this.invoiceAmount,
      this.invoiceImage});

  StoreOwnerInfo.Empty() {
    empty = true;
  }

  bool get isEmpty => empty;
}

class OrderInfo {
  int id = -1;
  OrderStatusEnum state = OrderStatusEnum.WAITING;
  String roomID = '';
  int ownerID = -1;
  String deliveryDate = '';
  double deliveryCost = 0;
  double orderCost = 0;
  String payment = '';
  String? note;
  Destination? destination;
  bool empty = false;
  int orderType = 0;
  String? orderDetails;
  String? recipientName;
  String? recipientPhoneNumber;
  bool? removable;
  String? invoiceImage;
  num? invoiceAmount;

  OrderInfo(
      {required this.id,
      required this.state,
      required this.roomID,
      required this.ownerID,
      required this.deliveryDate,
      required this.orderCost,
      required this.deliveryCost,
      required this.payment,
      this.note,
      this.destination,
      required this.orderType,
      this.orderDetails,
      this.recipientName,
      this.recipientPhoneNumber,
      required this.removable,
      this.invoiceImage,
      this.invoiceAmount});

  OrderInfo.Empty() {
    empty = true;
  }

  bool get isEmpty => empty;
}

List<StoreOwnerInfo> toCartList(List<OrderDetail> ordersItems) {
  if (ordersItems.isEmpty) return <StoreOwnerInfo>[];
  List<StoreOwnerInfo> items = [];
  ordersItems.forEach((element) {
    List<Item> orders = [];
    element.products?.forEach((product) {
      orders.add(Item(
          productID: product.productId ?? -1,
          productName: product.productName ?? S.current.product,
          productImage: product.productImage?.image ?? '',
          productPrice: product.productPrice?.toDouble() ?? 0,
          countProduct: product.countProduct ?? 1,
          storeOwnerProfileID: element.storeOwnerProfileId ?? -1,
          productCategoryID: product.productCategoryId ?? -1,
          orderNumber: product.orderNumber ?? '-1'));
    });
    items.add(StoreOwnerInfo(
        storeOwnerName: element.storeOwnerName ?? S.current.unknown,
        storeOwnerID: element.storeOwnerProfileId ?? -1,
        image: element.image?.image ?? '',
        items: orders,
        invoiceAmount: element.invoiceAmount?.toDouble(),
        invoiceImage: element.invoiceImage?.image));
  });
  return items;
}

OrderInfo toOrder(Order? order) {
  if (order != null) {
    bool timeout = false;
    var date = DateTime.fromMillisecondsSinceEpoch(
        (order.createdAt?.timestamp ?? DateTime.now().millisecondsSinceEpoch) *
            1000);
    if (DateTime.now().difference(date).inMinutes > 30) {
      timeout = true;
    }
    return OrderInfo(
        id: order.id ?? -1,
        state: StatusHelper.getStatusEnum(order.state),
        roomID: order.roomId ?? 'roomID',
        ownerID: -1,
        orderCost: order.orderCost?.toDouble() ?? 0,
        deliveryDate: DateTime.fromMillisecondsSinceEpoch(
                (order.deliveryDate?.timestamp ??
                        DateTime.now().millisecondsSinceEpoch) *
                    1000)
            .toUtc()
            .toIso8601String(),
        deliveryCost: order.deliveryCost?.toDouble() ?? 0,
        payment: order.payment!,
        note: order.note,
        destination: order.destination,
        orderType: order.orderType ?? 0,
        orderDetails: order.detail,
        recipientName: order.recipientName,
        recipientPhoneNumber: order.recipientPhone,
        invoiceAmount: null,
        invoiceImage: null,
        removable: !timeout);
  } else {
    return OrderInfo(
        id: -1,
        state: OrderStatusEnum.WAITING,
        roomID: 'roomID',
        ownerID: -1,
        deliveryDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        orderCost: 0,
        deliveryCost: 0,
        payment: 'cash',
        orderType: 0,
        removable: false);
  }
}

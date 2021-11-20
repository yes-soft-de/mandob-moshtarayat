import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/consts/order_status.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_details_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/date_converter.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/order_status_helper.dart';

class OrderDetailsModel extends DataModel {
  List<Item> carts = [];
  StoreOwnerInfo storeInfo = StoreOwnerInfo.Empty();
  OrderInfo order = OrderInfo.Empty();

  OrderDetailsModel? orderDetailsModel;

  OrderDetailsModel(
      {required this.carts, required this.storeInfo, required this.order});

  OrderDetailsModel.Data(OrderDetailsResponse response) {
    orderDetailsModel = OrderDetailsModel(
        carts: toCartList(response.data?.orderDetails ?? <OrderDetails>[]),
        order: toOrder(response.data?.order),
        storeInfo: StoreOwnerInfo(
          rating: num.parse(response.data?.storeOwner?.rating ?? '0'),
          storeOwnerID: response.data?.storeOwner?.storeOwnerID ?? -1,
          storeOwnerName:
              response.data?.storeOwner?.storeOwnerName ?? S.current.storeOwner,
          image: response.data?.storeOwner?.image ?? '',
          imageURL:
              'https://img.etimg.com/thumb/width-1200,height-900,imgsize-46347,resizemode-1,msid-79150455/news/international/business/pizza-hut-to-offer-pizzas-with-beyond-meat-sausages-in-u-s-uk.jpg',
        ));
  }

  bool get hasData => orderDetailsModel != null;

  OrderDetailsModel get data =>
      orderDetailsModel ??
      OrderDetailsModel(carts: carts, storeInfo: storeInfo, order: order);
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
  String imageURL = '';
  bool empty = false;
  num rating = 0;
  StoreOwnerInfo(
      {required this.storeOwnerName,
      required this.storeOwnerID,
      required this.image,
      required this.imageURL,
      required this.rating});

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
  String createAt = '';
  double deliveryCost = 0;
  double orderCost = 0;
  String payment = '';
  String? note;
  GeoJson? destination;
  bool empty = false;
  int orderType = 0;
  String? orderDetails;
  String? recipientName;
  String? recipientPhoneNumber;
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
      this.invoiceImage,
      this.invoiceAmount,
      required this.createAt});

  OrderInfo.Empty() {
    empty = true;
  }

  bool get isEmpty => empty;
}

List<Item> toCartList(List<OrderDetails> ordersItems) {
  if (ordersItems.isEmpty) return <Item>[];
  List<Item> items = [];
  ordersItems.forEach((element) {
    items.add(Item(
        productID: element.productID ?? -1,
        productName: element.productName ?? S.current.product,
        //element.productImage ??
        productImage: element.productImage?.image ?? '',
        productPrice: element.productPrice ?? 0,
        countProduct: element.countProduct ?? 1,
        storeOwnerProfileID: element.storeOwnerProfileID ?? -1,
        productCategoryID: element.productCategoryID ?? -1,
        orderNumber: element.orderNumber ?? '-1'));
  });
  return items;
}

OrderInfo toOrder(Order? order) {
  if (order != null) {
    return OrderInfo(
      id: order.id ?? -1,
      state: StatusHelper.getStatusEnum(order.state),
      roomID: order.roomID ?? 'roomID',
      ownerID: order.ownerID ?? -1,
      orderCost: order.orderCost ?? 0,
      deliveryDate: DateFormat.jm()
              .format(DateHelper.convert(order.deliveryDate?.timestamp)) +
          '   ' +
          DateFormat.yMd()
              .format(DateHelper.convert(order.deliveryDate?.timestamp)),
      createAt: DateFormat.jm()
              .format(DateHelper.convert(order.createdAt?.timestamp)) +
          '   ' +
          DateFormat.yMd()
              .format(DateHelper.convert(order.createdAt?.timestamp)),
      deliveryCost: order.deliveryCost ?? 0,
      payment: order.payment!,
      note: order.note,
      destination: order.destination,
      orderType: order.orderType ?? 0,
      orderDetails: order.detail,
      recipientName: order.recipientName,
      recipientPhoneNumber: order.recipientPhone,
      invoiceAmount: order.invoiceAmount,
      invoiceImage: order.invoiceImage,
    );
  } else {
    return OrderInfo(
      id: -1,
      state: OrderStatusEnum.WAITING,
      roomID: 'roomID',
      ownerID: -1,
      deliveryDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
      createAt: DateFormat('dd-MM-yyyy').format(DateTime.now()),
      orderCost: 0,
      deliveryCost: 0,
      payment: 'cash',
      orderType: 0,
    );
  }
}

import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat_captain/consts/order_status.dart';
import 'package:mandob_moshtarayat_captain/consts/urls.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/order_status/order_status_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders/geojson.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/order_status_helper.dart';

class OrderDetailsModel {
  List<Item> cart = [];
  StoreOwnerInfo storeInfo = StoreOwnerInfo.Empty();
  OrderInfo order = OrderInfo.Empty();
  String? _error;
  bool _empty = false;
  double? providedDistance;
  OrderDetailsModel? _orderDetailsModel;

  OrderDetailsModel(
      {required this.cart, required this.storeInfo, required this.order});

  OrderDetailsModel.Error(this._error);

  OrderDetailsModel.Empty() {
    _empty = true;
  }

  bool get isEmpty => _empty;

  bool get hasError => _error != null;

  String get error => _error ?? '';

  OrderDetailsModel.Data(OrderStatusResponse response, [LatLng? initLocation]) {
    List<Branches>? sortedBranches;
    LatLng? branchLocation;
    double? branchDistance;
    String? branch;
    response.data?.storeOwner ??= StoreOwner();
    response.data?.storeOwner?.branches ??= [];
    if (initLocation != null &&
        response.data!.storeOwner!.branches!.isNotEmpty) {
      sortedBranches = _sortLocations(
          response.data?.storeOwner?.branches ?? [], initLocation);
    }
    if (sortedBranches != null) {
      branchLocation = LatLng(sortedBranches.first.location?.lat ?? 0,
          sortedBranches.first.location?.long ?? 0);
      branchDistance = sortedBranches.first.distance;
      branch = sortedBranches.first.branchName;
    }
    _orderDetailsModel = OrderDetailsModel(
        cart: _toCartList(response.data?.orderDetails ?? <OrderDetails>[]),
        order: _toOrder(response.data?.order, initLocation),
        storeInfo: StoreOwnerInfo(
            branchName: branch,
            storeOwnerName: response.data?.storeOwner?.storeOwnerName ??
                S.current.storeOwner,
            storePhone: response.data?.storeOwner?.phone,
            image: response.data?.storeOwner?.image ?? Urls.IMAGES_ROOT,
            branchLocation: branchLocation,
            branchDistance: branchDistance));
  }

  bool get hasData => _orderDetailsModel != null;

  OrderDetailsModel get data =>
      _orderDetailsModel ??
      OrderDetailsModel(cart: cart, storeInfo: storeInfo, order: order);

  List<Branches> _sortLocations(List<Branches> branches, var defaultLoc) {
    if (defaultLoc == null && branches.length == 1) {
      return branches;
    }
    LatLng myPos = defaultLoc;
    final Distance distance = Distance();
    var sorted = branches;
    if (defaultLoc != null && branches.length == 1) {
      var pos = LatLng(branches.first.location?.lat ?? 0,
          branches.first.location?.long ?? 0);
      var straightDistance = distance.as(LengthUnit.Kilometer, pos, myPos);
      branches.first.distance = straightDistance;
      return branches;
    }

    sorted.sort((a, b) {
      try {
        var pos1 = LatLng(a.location?.lat ?? 0, a.location?.long ?? 0);
        var pos2 = LatLng(b.location?.lat ?? 0, b.location?.long ?? 0);
        var straightDistance1 = distance.as(LengthUnit.Kilometer, pos1, myPos);
        var straightDistance2 = distance.as(LengthUnit.Kilometer, pos2, myPos);
        a.distance = straightDistance1;
        b.distance = straightDistance2;
        return straightDistance1.compareTo(straightDistance2);
      } catch (e) {
        print(
            '##########################################################################');
        print(e);
        print(
            '##########################################################################');
        return 1;
      }
    });
    return sorted.toList();
  }

  double? _getDestination(LatLng? defaultLoc, GeoJson? sources) {
    if (defaultLoc == null || sources == null) {
      return null;
    }
    LatLng myPos = defaultLoc;
    final Distance distance = Distance();
    var pos1 = LatLng(sources.lat ?? 0, sources.long ?? 0);
    var straightDistance = distance.as(LengthUnit.Kilometer, pos1, myPos);
    return straightDistance.abs();
  }

  List<Item> _toCartList(List<OrderDetails> ordersItems) {
    if (ordersItems.isEmpty) return <Item>[];
    List<Item> items = [];
    ordersItems.forEach((element) {
      items.add(Item(
          productID: element.productID ?? -1,
          productName: element.productName ?? S.current.product,
          productImage: element.productImage?.image ?? Urls.IMAGES_ROOT,
          productPrice: element.productPrice ?? 0,
          countProduct: element.countProduct ?? 1,
          storeOwnerProfileID: element.storeOwnerProfileID ?? -1,
          productCategoryID: element.productCategoryID ?? -1,
          orderNumber: element.orderNumber ?? '-1'));
    });
    return items;
  }

  OrderInfo _toOrder(Order? order, [LatLng? defaultLoc]) {
    if (order != null) {
      LatLng? sourceLocation;
      LatLng? destinationLocation;
      double? sourceDistance;
      double? destinationDistance;

      if (order.orderType == 3 && order.source != null) {
        sourceLocation =
            LatLng(order.source?.lat ?? 0, order.source?.long ?? 0);
      }
      if (order.destination != null) {
        destinationLocation =
            LatLng(order.destination?.lat ?? 0, order.destination?.long ?? 0);
      }

      if (defaultLoc != null) {
        if (sourceLocation != null)
          sourceDistance = _getDestination(defaultLoc, order.source);
        if (destinationLocation != null)
          destinationDistance = _getDestination(defaultLoc, order.destination);
      }

      var date = DateTime.fromMillisecondsSinceEpoch(
              (order.deliveryDate?.timestamp ??
                      DateTime.now().millisecondsSinceEpoch) *
                  1000)
          .toIso8601String();
      return OrderInfo(
          id: order.id ?? -1,
          state: StatusHelper.getStatusEnum(order.state),
          roomID: order.roomID ?? 'roomID',
          ownerID: order.storeOwnerProfileID ?? -1,
          orderCost: order.orderCost ?? 0,
          deliveryDate: date,
          deliveryCost: order.deliveryCost ?? 0,
          payment: order.payment!,
          note: order.note ?? '',
          destination: destinationLocation,
          orderType: order.orderType ?? 0,
          orderDetails: order.detail,
          recipientName: order.recipientName,
          recipientPhoneNumber: order.recipientPhone,
          source: sourceLocation,
          sourceDistanceValue: sourceDistance,
          destinationDistanceValue: destinationDistance);
    } else {
      return OrderInfo.Empty();
    }
  }
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
  String image = '';
  bool _empty = false;
  String? storePhone;
  LatLng? branchLocation;
  double? branchDistance;
  String? branchName;
  StoreOwnerInfo(
      {required this.storeOwnerName,
      required this.image,
      this.storePhone,
      this.branchLocation,
      this.branchDistance,
      this.branchName});

  StoreOwnerInfo.Empty() {
    _empty = true;
  }

  bool get isEmpty => _empty;
}

class OrderInfo {
  int id = -1;
  OrderStatus state = OrderStatus.WAITING;
  String roomID = '';
  int ownerID = -1;
  String deliveryDate = '';
  double deliveryCost = 0;
  double orderCost = 0;
  String payment = '';
  String note = '';
  LatLng? source;
  LatLng? destination;
  bool _empty = false;
  int orderType = 0;
  String? orderDetails;
  String? recipientName;
  String? recipientPhoneNumber;
  double? sourceDistanceValue;
  double? destinationDistanceValue;
  OrderInfo(
      {required this.id,
      required this.state,
      required this.roomID,
      required this.ownerID,
      required this.deliveryDate,
      required this.orderCost,
      required this.deliveryCost,
      required this.payment,
      this.note = '',
      this.destination,
      required this.orderType,
      this.orderDetails,
      this.recipientName,
      this.recipientPhoneNumber,
      this.source,
      this.sourceDistanceValue,
      this.destinationDistanceValue});

  OrderInfo.Empty() {
    _empty = true;
  }

  bool get isEmpty => _empty;
}

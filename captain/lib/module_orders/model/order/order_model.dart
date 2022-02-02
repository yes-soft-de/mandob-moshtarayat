import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders/geojson.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders/order_response.dart';

class OrderModel {
  late int id;
  late String orderNumber;
  LatLng? branchLocation;
  late DateTime deliveryDate;
  late String paymentMethod;
  String? details;
  int? storeId;
  String? storeName;
  String? branchName;
  int? branchId;
  String? branchCity;
  double deliveryCost = 0;
  double orderCost = 0;
  String? ownerPhone;
  String? image;
  String? clientPhone;
  String? chatRoomId;
  double? storeDistance;
  LatLng? costumerLocation;
  LatLng? _currentLocation;
  late int orderType;

  OrderModel(
      {required this.id,
      required this.paymentMethod,
      this.storeName,
      this.ownerPhone,
      this.clientPhone,
      this.chatRoomId,
      this.storeDistance,
      this.branchLocation,
      this.costumerLocation,
      required this.deliveryDate,
      this.image,
      required this.deliveryCost,
      required this.orderCost,
      required this.orderNumber,
      this.storeId,
      this.branchCity,
      this.branchId,
      this.branchName,
      this.details,
      required this.orderType});

  String? _error;
  bool _empty = false;
  final List<OrderModel> _models = [];

  OrderModel.error(this._error);

  OrderModel.empty() {
    _empty = true;
  }

  OrderModel.withData(List<Data> data, [LatLng? initLocation]) {
    _currentLocation = initLocation;
    data.forEach((element) {
      bool allow = false;
      int nextYear = DateTime.now().year + 1;
      int timestamp = element.deliveryDate?.timestamp ??
          DateTime(nextYear).millisecondsSinceEpoch;

      var creationDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

      if (creationDate.difference(DateTime.now()).inMinutes <= 45) allow = true;

      if (allow) {
        _models.add(OrderModel(
            id: element.id ?? -1,
            storeName: element.storeOwnerName ?? S.current.store,
            ownerPhone: null,
            clientPhone: null,
            chatRoomId: null,
            storeDistance: null,
            branchLocation: null,
            deliveryDate: creationDate,
            image: element.image,
            deliveryCost: element.deliveryCost ?? 0,
            orderCost: element.orderCost ?? 0,
            orderNumber: element.orderNumber ?? '0',
            storeId: element.storeOwnerProfileID,
            branchCity: null,
            branchId: null,
            branchName: null,
            details: element.detail,
            orderType: element.orderType ?? 0,
            paymentMethod: element.payment ?? 'cash'));
      }
    });
    if (_models.isEmpty) _empty = true;
  }
  bool get hasError => _error != null;

  bool get empty => _empty;

  bool get hasData => _models.isNotEmpty;

  List<OrderModel> get data => _models;

  String get error => _error ?? '';
  LatLng? get currentLocation => _currentLocation;
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

  // bool disableOrder(
  //     Data element, List<Branches>? sortedBranches, LatLng? initLocation) {
  //   if (element.orderType == null) {
  //     print('Order ID => ${element.id} for reason order type is null');
  //     return false;
  //   }
  //   if (element.orderNumber == null) {
  //     print('Order ID => ${element.id} for reason order number is null');
  //     return false;
  //   }
  //   if (element.orderType != 3 && element.branches!.isEmpty) {
  //     print('Order ID => ${element.id} for reason there is no branches');
  //     return false;
  //   }
  //   if (element.orderType == 3 && element.source == null) {
  //     print('Order ID => ${element.id} for reason source is null');
  //     return false;
  //   }
  //   if (element.orderType != 3 &&
  //       sortedBranches != null &&
  //       (sortedBranches.first.distance ?? 0) > 5500) {
  //     print('Order ID => ${element.id} for reason store is too far');
  //     return false;
  //   }
  //   if (element.orderType == 3 &&
  //       element.source != null &&
  //       initLocation != null &&
  //       _getDestination(initLocation, element.source)! > 5500) {
  //     print('Order ID => ${element.id} for reason there is no destination or source');
  //     return false;
  //   }
  //   return true;
  // }
}

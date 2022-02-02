import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat_captain/consts/order_status.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders/accept_order_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders/geojson.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders/order_response.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/order_status_helper.dart';

class AcceptOrderModel {
  late int id;
  late String orderNumber;
  late DateTime deliveryDate;
  String? details;
  int? storeId;
  String? storeName;
  LatLng? _currentLocation;
  late int orderType;
  late OrderStatus state;
  AcceptOrderModel(
      {required this.id,
      this.storeName,
      required this.deliveryDate,
      required this.orderNumber,
      this.storeId,
      this.details,
      required this.orderType,
      required this.state});

  String? _error;
  bool _empty = false;
  final List<AcceptOrderModel> _models = [];

  AcceptOrderModel.error(this._error);

  AcceptOrderModel.empty() {
    _empty = true;
  }

  AcceptOrderModel.withData(AcceptOrderResponse response,
      [LatLng? initLocation]) {
    List<AcceptedOrder> data = response.data ?? [];

    for (var element in data) {
      int timestamp = element.deliveryDate?.timestamp ??
          DateTime.now().millisecondsSinceEpoch;
      var creationDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      _models.add(AcceptOrderModel(
        id: element.id ?? -1,
        storeName: element.storeOwnerName ?? S.current.store,
        deliveryDate: creationDate,
        orderNumber: element.orderNumber.toString(),
        orderType: element.orderType ?? 0,
        state: StatusHelper.getStatusEnum(element.state),
      ));
    }
  }

  bool get hasError => _error != null;

  bool get empty => _empty;

  bool get hasData => _models.isNotEmpty;

  List<AcceptOrderModel> get data => _models;

  String get error => _error ?? '';

  LatLng? get currentLocation => _currentLocation;
}

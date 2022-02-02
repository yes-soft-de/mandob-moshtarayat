import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_captain/consts/order_status.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders_logs_response.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/order_status_helper.dart';

class OrderLogsModel {
  late String orderNumber;
  late OrderStatus state;
  late DateTime dateTime;
  late String orderDate;
  late String? completeTime;
  String? _error;
  bool _empty = false;
  List<OrderLogsModel> _models = [];

  OrderLogsModel(
      {required this.orderNumber,
      required this.state,
      required this.dateTime,
      required this.orderDate,
      required this.completeTime});

  OrderLogsModel.Empty() {
    this._empty = true;
  }

  OrderLogsModel.Error(this._error);

  OrderLogsModel.Data(OrdersLogsResponse orders) {
    List<Data> data = orders.data ?? [];
    for (var element in data) {
      if (element.currentStage?.toString() != 'delivered' &&
          element.currentStage?.toString() != 'cancelled') {
        continue;
      }
      String date = DateFormat('dd-MM-yyyy').format(
          DateTime.fromMillisecondsSinceEpoch((element.createdAt?.timestamp ??
                  DateTime.now().millisecondsSinceEpoch) *
              1000));
      DateTime createdDate = DateTime.fromMillisecondsSinceEpoch(
          (element.createdAt?.timestamp ??
                  DateTime.now().millisecondsSinceEpoch) *
              1000);

      _models.add(OrderLogsModel(
          orderNumber: element.orderNumber?.toString() ?? S.current.unknown,
          state: StatusHelper.getStatusEnum(
              element.currentStage ?? S.current.unknown),
          dateTime: createdDate,
          orderDate: date,
          completeTime: element.completionTime));
    }
    if (_models.isEmpty) {
      _empty = true;
    }
  }

  bool get hasError => _error != null;
  String get error => _error ?? '';
  bool get isEmpty => _empty;

  List<OrderLogsModel> get data {
    if (_models.isEmpty || _models.length == 1) {
      return _models;
    }
    _models.sort((order1, order2) {
      DateTime date1 = order1.dateTime;
      DateTime date2 = order2.dateTime;
      return date1.compareTo(date2);
    });
    return _models.reversed.toList();
  }
}

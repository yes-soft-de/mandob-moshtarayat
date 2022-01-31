import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat/consts/order_status.dart';
import 'package:mandob_moshtarayat/module_orders/response/my_orders_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/order_status_helper.dart';

class OrderModel {
  late String orderDate;
  late String orderId;
  late OrderStatus orderStatus;
  late DateTime dateTime;
  late double orderCost;
  String? error;
  bool empty = false;
  List<OrderModel> models = [];
  OrderModel(
      {required this.orderDate,
      required this.orderId,
      required this.orderStatus,
      required this.orderCost,
      required this.dateTime});
  OrderModel.Empty() {
    this.empty = true;
  }
  OrderModel.Error(this.error);

  OrderModel.Data(MyOrdersResponse orders) {
    var data = orders.data;
    data?.forEach((element) {
      var orderCost = element.orderCost ?? 0;
      String date = DateFormat('dd-MM-yyyy').format(
          DateTime.fromMillisecondsSinceEpoch(
              (element.deliveryDate?.timestamp ??
                      DateTime.now().millisecondsSinceEpoch) *
                  1000));
      models.add(OrderModel(
          dateTime: DateTime.fromMillisecondsSinceEpoch(
              (element.deliveryDate?.timestamp ??
                      DateTime.now().millisecondsSinceEpoch) *
                  1000),
          orderDate: date,
          orderId: element.orderNumber ?? '-1',
          orderStatus: StatusHelper.getStatusEnum(element.state),
          orderCost:element.vatTax?.total ?? 0));
    });
  }
  bool get hasError => error != null;

  bool get isEmpty => empty;

  List<OrderModel> get data {
    models.sort((order1, order2) {
      DateTime date1 = order1.dateTime;
      DateTime date2 = order2.dateTime;
      return date1.compareTo(date2);
    });
    return models.reversed.toList();
  }
}

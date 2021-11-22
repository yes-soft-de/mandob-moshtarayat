import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/consts/order_status.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_time_line_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/date_converter.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/order_status_helper.dart';

class OrderTimeLineModel extends DataModel {
  OrderStatusTimeLine orderStatus = OrderStatusTimeLine.empty();
  List<Logs> logs = [];

  OrderTimeLineModel.withData(Data data) : super.withData() {
    orderStatus = OrderStatusTimeLine(
        deliveredTime: data.orderStatus?.deliveredTime ?? '',
        completionTime: data.orderStatus?.completionTime ?? '',
        currentStage:
            StatusHelper.getStatusEnum(data.orderStatus?.currentStage));
    data.logs?.forEach((element) {
      logs.add(Logs(
          id: element.id ?? -1,
          state: StatusHelper.getStatusEnum(element.state),
          createdAt: DateHelper.convert(element.createdAt?.timestamp)));
    });
  }
}

class OrderStatusTimeLine {
  String completionTime = '';
  OrderStatusEnum currentStage = OrderStatusEnum.WAITING;
  String deliveredTime = '';
  OrderStatusTimeLine(
      {required this.completionTime,
      required this.currentStage,
      required this.deliveredTime});

  OrderStatusTimeLine.empty();
}

class Logs {
  int id;
  OrderStatusEnum state;
  DateTime createdAt;

  Logs({required this.id, required this.state, required this.createdAt});
}

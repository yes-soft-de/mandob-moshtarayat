import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/consts/order_status.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/response/captain_logs_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/date_converter.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/order_status_helper.dart';

class CaptainLogsModel extends DataModel {
  DateTime deliveryDate = DateTime.now();
  OrderStatusEnum state = StatusHelper.getStatusEnum('waiting');
  DateTime createdAt = DateTime.now();
  String orderNumber = '';
  num amount = 0;
  num deliveryCost = 0;
  num orderCost = 0;
  num orderType = -1;
  int _countPrivate = 0;
  int _countProductOrder = 0;
  int _countSendOnMeOrder = 0;

  List<CaptainLogsModel> _model = [];

  CaptainLogsModel(
      {required this.deliveryDate,
      required this.state,
      required this.createdAt,
      required this.orderNumber,
      required this.orderType,
      required this.amount,
      required this.deliveryCost,
      required this.orderCost});

  CaptainLogsModel.withData(Data data) : super.withData() {
    _model = [];
    for (var element in data.orders!) {
      if (element.orderType == 1) _countProductOrder++;
      if (element.orderType == 2) _countPrivate++;
      if (element.orderType == 3) _countSendOnMeOrder++;
      _model.add(CaptainLogsModel(
          createdAt: DateHelper.convert(element.createdAt?.timestamp),
          deliveryDate: DateHelper.convert(element.deliveryDate?.timestamp),
          orderNumber: element.orderNumber ?? '-1',
          orderType: element.orderType ?? -1,
          state: StatusHelper.getStatusEnum(element.state ?? ''),
          orderCost: element.orderCost ?? 0,
          deliveryCost: element.deliveryCost ?? 0,
          amount: element.deliveryCost ?? 0));
    }
  }
  List<CaptainLogsModel> get data => _model;

  int get countPrivateOrder => _countPrivate;
  int get countProductOrder => _countProductOrder;
  int get countSendOnMeOrder => _countSendOnMeOrder;
}

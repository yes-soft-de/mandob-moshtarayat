import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_main/response/report_response.dart';

class ReportModel extends DataModel {
  int countCompletedOrders = 0;
  int countOngoingOrders = 0;
  int countCaptains = 0;
  int countClients = 0;
  int countStores = 0;
  int countProducts = 0;
  int countOrdersInToday = 0;

  ReportModel(
      {required this.countCompletedOrders,
      required this.countOngoingOrders,
      required this.countCaptains,
      required this.countClients,
      required this.countStores,
      required this.countProducts});

  ReportModel.withData(Data data) : super.withData() {
    countCompletedOrders = int.parse(data.countCompletedOrders ?? '0');
    countOngoingOrders = int.parse(data.countOngoingOrders ?? '0');
    countCaptains = int.parse(data.countCaptains ?? '0');
    countClients = int.parse(data.countClients ?? '0');
    countStores = int.parse(data.countStores ?? '0');
    countProducts = int.parse(data.countProducts ?? '0');
    countOrdersInToday = int.parse(data.countOrdersInToday ?? '0');
  }
}

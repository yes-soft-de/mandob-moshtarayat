import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/module_home/response/report_response.dart';

class ReportModel extends DataModel {

  int countCompletedOrders = 0;
  int countOngoingOrders = 0;
  int countOrdersInToday = 0;

  ReportModel(
      {required this.countCompletedOrders,
      required this.countOngoingOrders,
        required this.countOrdersInToday
      });

  ReportModel.withData(Data data) : super.withData() {
     countCompletedOrders =int.parse(data.countCompletedOrders ?? '0');
     countOngoingOrders =int.parse(data.countOngoingOrders ?? '0');
     countOrdersInToday =int.parse(data.countOrdersInToday ?? '0');

  }

}

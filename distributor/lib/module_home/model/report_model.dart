import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/module_home/response/report_response.dart';

class ReportModel extends DataModel {

  int totalLinkedStores = 0;
  int representativeTotalLinkedStores = 0;
  int representativeLinkedStoresLastMonth = 0;

  ReportModel(
      {required this.totalLinkedStores,
      required this.representativeTotalLinkedStores,
        required this.representativeLinkedStoresLastMonth
      });

  ReportModel.withData(Data data) : super.withData() {
    totalLinkedStores = data.totalLinkedStores  ??0;
    representativeTotalLinkedStores =  data.representativeTotalLinkedStores ??0;
    representativeLinkedStoresLastMonth = data.representativeLinkedStoresLastMonth  ??0;

  }

}

import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/response/reports_store_response.dart';

class StoresReportModel extends DataModel {
  int storeOwnerProfileID = -1;
  int countOrdersInMonth = 0;
  String storeOwnerName = '';
  String image = '';

  StoresReportModel(
      {required this.storeOwnerProfileID,
      required this.storeOwnerName,
      required this.image,
      required this.countOrdersInMonth});

  List<StoresReportModel> _models = [];

  StoresReportModel.withData(List<Data> data) : super.withData() {
    _models = [];
    data.forEach((element) {
      _models.add(StoresReportModel(
          storeOwnerProfileID: element.storeOwnerProfileID ?? -1,
          countOrdersInMonth: element.countOrdersInMonth ?? 0,
          image: element.image ?? '',
          storeOwnerName: element.storeOwnerName ?? ''));
    });
  }

  List<StoresReportModel> get data => _models;
}

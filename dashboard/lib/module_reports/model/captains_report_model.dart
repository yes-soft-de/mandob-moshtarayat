import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/response/reports_captain_response.dart';

class CaptainsReportModel extends DataModel {
  String captainID = '-1';
  int countOrdersInMonth = 0;
  String captainName = '';
  String image = '';

  CaptainsReportModel(
      {required this.captainID,
      required this.captainName,
      required this.image,
      required this.countOrdersInMonth});

  List<CaptainsReportModel> _models = [];

  CaptainsReportModel.withData(List<Data> data) : super.withData() {
    _models = [];
    data.forEach((element) {
      _models.add(CaptainsReportModel(
          captainID: element.captainID ?? '-1',
          countOrdersInMonth: element.countOrdersInMonth ?? 0,
          image: element.image ?? '',
          captainName: element.captainName ?? ''));
    });
  }

  List<CaptainsReportModel> get data => _models;
}

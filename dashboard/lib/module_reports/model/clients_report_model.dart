import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/response/reports_client_response.dart';

class ClientsReportModel extends DataModel {
  String clientID = '-1';
  int countOrdersInMonth = 0;
  String clientName = '';
  String image = '';

  ClientsReportModel(
      {required this.clientID,
      required this.clientName,
      required this.image,
      required this.countOrdersInMonth});

  List<ClientsReportModel> _models = [];

  ClientsReportModel.withData(List<Data> data) : super.withData() {
    _models = [];
    data.forEach((element) {
      _models.add(ClientsReportModel(
          clientID: element.clientID ?? '-1',
          countOrdersInMonth: element.countOrdersInMonth ?? 0,
          image: element.image ?? '',
          clientName: element.clientName ?? ''));
    });
  }

  List<ClientsReportModel> get data => _models;
}

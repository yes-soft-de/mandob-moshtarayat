import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/response/client_need_support_response/datum.dart';

class ClientsNeedSupportModel extends DataModel {
  String roomID = '';
  String clientName = '';
  String image = '';
  String id = '';
  String clientID = '';
  List<ClientsNeedSupportModel> _model = [];

  ClientsNeedSupportModel({
    required this.roomID,
    required this.image,
    required this.clientName,
    required this.id,
    required this.clientID
  });

  ClientsNeedSupportModel.withData(List<Datum> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(ClientsNeedSupportModel(
          roomID: element.roomId ?? '-1',
          image: element.image ?? '',
          clientName: element.clientName ?? '',
          id: element.id?.toString() ?? '',
          clientID: element.clientID ?? '-1'
          ));
    }
  }
  List<ClientsNeedSupportModel> get data => _model;
}

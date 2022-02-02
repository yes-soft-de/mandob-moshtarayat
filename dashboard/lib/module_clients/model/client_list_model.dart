import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/response/clients_list_profile.dart';

class ClientsListModel extends DataModel {
  String clientID = '';
  String clientName = '';
  String image = '';
  String id = '';

  List<ClientsListModel> _model = [];

  ClientsListModel({
    required this.clientID,
    required this.image,
    required this.clientName,
    required this.id,
  });

  ClientsListModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(ClientsListModel(
          clientID: element.clientID ?? '-1',
          image: element.image ?? '',
          clientName: element.clientName ?? '',
          id: element.id?.toString() ?? ''));
    }
  }
  List<ClientsListModel> get data => _model;
}

import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/response/client_profile_response.dart';

class ClientProfileModel extends DataModel {
  String? image;
  String? name;
  String? phone;
  String? nationalAddress;
  String? recordNumber;
  String? taxNumber;
  Statistics? statistics;

  ClientProfileModel({this.image, this.name, this.phone, this.statistics , this.taxNumber , this.recordNumber,this.nationalAddress});

  ClientProfileModel? _models;

  ClientProfileModel.withData(Data data) : super.withData() {
    _models = ClientProfileModel(
      image: data.image,
      name: data.clientName,
      phone: data.phone,
      nationalAddress: data.nationalAddress,
      recordNumber: data.recordNumber,
      taxNumber: data.taxNumber,
      statistics: Statistics(
        clientOrdersCancel:
            int.parse(data.statistics?.clientOrdersCancel ?? '0'),
        clientOrdersDelivered:
            int.parse(data.statistics?.clientOrdersDelivered ?? '0'),
        clientOrdersCount: int.parse(data.statistics?.clientOrdersCount ?? '0'),
      ),
    );
  }

  ClientProfileModel get data => _models ?? ClientProfileModel();
}

class Statistics {
  int clientOrdersCount;
  int clientOrdersCancel;
  int clientOrdersDelivered;

  Statistics(
      {required this.clientOrdersCount,
      required this.clientOrdersCancel,
      required this.clientOrdersDelivered});
}

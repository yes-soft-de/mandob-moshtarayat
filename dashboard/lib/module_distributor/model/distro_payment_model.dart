import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distro_unfinished_pyments_response.dart';

class DistroPaymentModel extends DataModel {
  int? id;
  String mandobID = '-1';
  String? mandobName = '';
  String? roomID = '';
  String? image = '';
  String? phone = '';
  num? remainingAmountForMandob;

  List<DistroPaymentModel> _model = [];

  DistroPaymentModel(
      {required this.mandobID,
      required this.image,
      required this.mandobName,
      required this.phone,
      required this.id,
      required this.remainingAmountForMandob,
      required this.roomID});

  DistroPaymentModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(DistroPaymentModel(
          mandobID: element.mandobID ?? '-1',
          image: element.image?.imageUrl ?? '',
          mandobName: element.mandobName ?? '',
          remainingAmountForMandob: element.remainingAmountForRepresentative ?? 0,
          roomID: element.roomID ?? '',
          id: element.id,
          phone: element.phone ?? ''));
    }
  }
  List<DistroPaymentModel> get data => _model;
}

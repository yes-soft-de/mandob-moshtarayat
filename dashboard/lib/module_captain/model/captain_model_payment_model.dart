import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_unfinished_pyments_response.dart';

class CaptainPaymentModel extends DataModel {
  int? id;
  String captainID = '-1';
  String? captainName = '';
  String? roomID = '';
  String? image = '';
  String? phone = '';
  num? remainingAmountForCaptain;

  List<CaptainPaymentModel> _model = [];

  CaptainPaymentModel(
      {required this.captainID,
      required this.image,
      required this.captainName,
      required this.phone,
      required this.id,
      required this.remainingAmountForCaptain,
      required this.roomID});

  CaptainPaymentModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(CaptainPaymentModel(
          captainID: element.captainID ?? '-1',
          image: element.image ?? '',
          captainName: element.captainName ?? '',
          remainingAmountForCaptain: element.remainingAmountForCaptain ?? 0,
          roomID: element.roomID ?? '',
          id: element.id,
          phone: element.phone ?? ''));
    }
  }
  List<CaptainPaymentModel> get data => _model;
}

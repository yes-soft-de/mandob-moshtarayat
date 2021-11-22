import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/captain_remaining_payments_response.dart';

class OrderAccountModel extends DataModel {
  num totalPaymentsAmount = 0;
  List<CaptainFromPaymentsModel> captains = [];
  OrderAccountModel(
      {required this.totalPaymentsAmount, required this.captains});

  OrderAccountModel.withData(Data data) : super.withData() {
    totalPaymentsAmount = data.totalAmountForCompany ?? 0;
    for (var element in data.captains!) {
      captains.add(CaptainFromPaymentsModel(
          captainID: element.captainID ?? '-1',
          image: element.image ?? '',
          captainName: element.captainName ?? '',
          remainingAmountForCaptain: element.remainingAmountForCompany ?? 0,
          roomID: element.roomID ?? '',
          id: element.id,
          phone: element.phone ?? ''));
    }
  }
  OrderAccountModel get data => OrderAccountModel(
      totalPaymentsAmount: totalPaymentsAmount, captains: captains);
}

class CaptainFromPaymentsModel {
  int? id;
  String captainID = '-1';
  String? captainName = '';
  String? roomID = '';
  String? image = '';
  String? phone = '';
  num? remainingAmountForCaptain;
  CaptainFromPaymentsModel(
      {required this.captainID,
      required this.image,
      required this.captainName,
      required this.phone,
      required this.id,
      required this.remainingAmountForCaptain,
      required this.roomID});
}

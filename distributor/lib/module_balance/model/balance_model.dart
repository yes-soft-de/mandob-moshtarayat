
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/module_balance/response/balance_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/date_converter.dart';

class BalanceModel extends DataModel{
  num? sumPaymentToRepresentative= 0;
  num? sumRepresentativeDue=0;
  num? totalRemainingPaymentsToRepresentative=0;
  List<PaymentsModel> payments=[];

  BalanceModel? balanceModel;

  BalanceModel( { this.sumRepresentativeDue, this.sumPaymentToRepresentative, this.totalRemainingPaymentsToRepresentative,
    required this.payments});
  BalanceModel.withData(Data data ):super.withData(){

    data.paymentsToRepresentative!.forEach((v) {
      payments.add(PaymentsModel(
          date: DateHelper.convert(v.date?.timestamp),
          note: v.note??'',
          id: v.id??-1,
          amount: v.amount??0));
    });
    balanceModel = BalanceModel(
        sumPaymentToRepresentative: data.sumPaymentToRepresentative??0,
        sumRepresentativeDue: data.sumRepresentativeDue??0,
        totalRemainingPaymentsToRepresentative: data.totalRemainingPaymentsToRepresentative??0,
        payments: payments );

  }


}


class PaymentsModel extends DataModel {
  int id=-1;
  num amount=0;
  String note='';
  DateTime date=DateTime.now();

  PaymentsModel? _model;

  PaymentsModel({required this.id,required this.amount,required this.note,required this.date});
  PaymentsModel.withData(Amount data) : super.withData() {
    _model = PaymentsModel(
        id: data.id??-1,
        amount: data.amount??-1,
        note: note,
        date: DateHelper.convert(data.date?.timestamp));
  }

  PaymentsModel get data {
    if (_model != null) {
      return _model!;
    }
    else {
      throw Exception('There is no data');
    }
  }

}

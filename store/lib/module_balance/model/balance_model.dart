import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/module_balance/responce/balance_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/date_converter.dart';

class BalanceModel extends DataModel{
  num amountOwedToStore= 0;
  num sumPaymentsToStore=0;
  num total=0;
  List<PaymentsModel> payments=[];

  BalanceModel? balanceModel;

  BalanceModel( {required this.amountOwedToStore,required this.sumPaymentsToStore,required this.total,
     required this.payments});
  BalanceModel.withData(Data data ):super.withData(){
    data.paymentsToStore!.forEach((v) {
      payments.add(PaymentsModel(
          date: DateHelper.convert(v.date?.timestamp),
          note: v.note??'',
          id: v.id??-1,
          amount: v.amount??0));
    });
    balanceModel = BalanceModel(
        amountOwedToStore: data.amountOwedToStore??0,
        sumPaymentsToStore: data.sumPaymentsToStore??0,
        total: data.total??0, payments: payments);

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
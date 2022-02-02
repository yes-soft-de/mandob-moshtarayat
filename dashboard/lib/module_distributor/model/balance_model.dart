import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distro_account_balance_response.dart';

class BalanceModel extends DataModel {
  AccountBalance? _models;

  BalanceModel();

  BalanceModel.withData(Data data) {
    List<PaymentModel> paymentsToRepresentative = [];
    data.paymentsToRepresentative?.forEach((element) {
      paymentsToRepresentative.add(PaymentModel(
          id: element.id ?? -1,
          note: element.note,
          paymentDate: DateTime.fromMillisecondsSinceEpoch(
              (element.date?.timestamp ?? 0) * 1000),
          amount: element.amount));
    });
    _models = AccountBalance(
      sumPaymentToRepresentative: data.sumPaymentToRepresentative ?? 0,
      sumRepresentativeDue: data.sumRepresentativeDue ?? 0,
      totalRemainingPaymentsToRepresentative: data.totalRemainingPaymentsToRepresentative ?? 0,
      paymentsToRepresentative: paymentsToRepresentative,
    );
  }

  AccountBalance? get data {
    return _models;
  }
}

class PaymentModel {
  int id;
  DateTime paymentDate;
  var amount;
  String? note;
  PaymentModel(
      {required this.id,
      required this.paymentDate,
      required this.amount,
      this.note});
}

class AccountBalance extends BalanceModel {
  num sumPaymentToRepresentative;
  num sumRepresentativeDue;
  num totalRemainingPaymentsToRepresentative;
  List<PaymentModel> paymentsToRepresentative = [];

  AccountBalance(
      {required this.sumRepresentativeDue,
      required this.sumPaymentToRepresentative,
      required this.paymentsToRepresentative,
      required this.totalRemainingPaymentsToRepresentative,});

  AccountBalance.none({
    this.sumRepresentativeDue = 0,
    this.sumPaymentToRepresentative = 0,
    this.totalRemainingPaymentsToRepresentative = 0,
  }) : super();
}

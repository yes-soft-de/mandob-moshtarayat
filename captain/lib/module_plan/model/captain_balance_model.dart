import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_plan/response/account_balance_response.dart';

class BalanceModel {
  String? _error;
  bool _empty = false;
  AccountBalance? _models;

  BalanceModel.error(this._error);

  BalanceModel.empty() {
    _empty = true;
  }

  BalanceModel.withData(Data data) {
    _models = AccountBalance(
      sumPaymentsFromCompany: data.sumPaymentsFromCompany ?? 0,
      sumPaymentsToCompany: data.sumPaymentsToCompany ?? 0,
      countOrdersDelivered: data.countOrdersDelivered ?? 0,
      sumInvoiceAmount: data.sumInvoiceAmount ?? 0,
      deliveryCost: data.deliveryCost ?? 0,
      amountYouOwn: data.amountYouOwn ?? 0,
      remainingAmountForCompany: data.remainingAmountForCompany ?? 0,
      salary: data.salary ?? 0,
      bounce: data.bounce ?? 0,
      kilometerBonus: data.kilometerBonus ?? 0,
      netProfit: data.netProfit ?? 0,
      total: data.total ?? 0,
    );
  }

  bool get hasError => _error != null;

  bool get empty => _empty;

  AccountBalance? get data {
    return _models;
  }

  String get error => _error ?? S.current.errorHappened;
}

class PaymentModel {
  DateTime paymentDate;
  var amount;

  PaymentModel(this.paymentDate, this.amount);
}

class AccountBalance extends BalanceModel {
  num sumPaymentsFromCompany;
  num sumPaymentsToCompany;
  num countOrdersDelivered;
  num sumInvoiceAmount;
  num deliveryCost;
  num amountYouOwn;
  num remainingAmountForCompany;
  num salary;
  num bounce;
  num kilometerBonus;
  num netProfit;
  num total;

  AccountBalance(
      {required this.sumPaymentsFromCompany,
      required this.sumPaymentsToCompany,
      required this.countOrdersDelivered,
      required this.sumInvoiceAmount,
      required this.deliveryCost,
      required this.amountYouOwn,
      required this.remainingAmountForCompany,
      required this.salary,
      required this.bounce,
      required this.kilometerBonus,
      required this.netProfit,
      required this.total})
      : super.empty();

  AccountBalance.none(
      {this.sumPaymentsFromCompany = 0,
      this.sumPaymentsToCompany = 0,
      this.countOrdersDelivered = 0,
      this.sumInvoiceAmount = 0,
      this.deliveryCost = 0,
      this.amountYouOwn = 0,
      this.remainingAmountForCompany = 0,
      this.salary = 0,
      this.bounce = 0,
      this.kilometerBonus = 0,
      this.netProfit = 0,
      this.total = 0})
      : super.empty();
}

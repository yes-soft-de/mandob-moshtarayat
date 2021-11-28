import 'package:mandob_moshtarayat_captain/utils/logger/logger.dart';

class AccountBalanceResponse {
  String? statusCode;
  String? msg;
  Data? data;

  AccountBalanceResponse({this.statusCode, this.msg, this.data});

  AccountBalanceResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        if (json['Data'] is List) {
          data =
              json['Data'].isNotEmpty ? Data.fromJson(json['Data'][0]) : null;
        }
      }
    } catch (e) {
      Logger()
          .error('Account Balance Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    return map;
  }
}

class Data {
  num? sumPaymentsFromCompany;
  num? sumPaymentsToCompany;
  num? countOrdersDelivered;
  num? sumInvoiceAmount;
  num? deliveryCost;
  num? amountYouOwn;
  num? remainingAmountForCompany;
  num? salary;
  num? bounce;
  num? kilometerBonus;
  num? netProfit;
  num? total;

  Data(
      {this.sumPaymentsFromCompany,
      this.sumPaymentsToCompany,
      this.countOrdersDelivered,
      this.sumInvoiceAmount,
      this.deliveryCost,
      this.amountYouOwn,
      this.remainingAmountForCompany,
      this.salary,
      this.bounce,
      this.kilometerBonus,
      this.netProfit,
      this.total});

  Data.fromJson(dynamic json) {
    sumPaymentsFromCompany = json['sumPaymentsFromCompany'];
    sumPaymentsToCompany = json['sumPaymentsToCompany'];
    countOrdersDelivered = json['countOrdersDelivered'];
    sumInvoiceAmount = json['sumInvoiceAmount'];
    deliveryCost = json['deliveryCost'];
    amountYouOwn = json['amountYouOwn'];
    remainingAmountForCompany = json['remainingAmountForCompany'];
    salary = json['salary'];
    bounce = json['bounce'];
    kilometerBonus = json['kilometerBonus'];
    netProfit = json['netProfit'] ?? json['NetProfit'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['sumPaymentsFromCompany'] = sumPaymentsFromCompany;
    map['sumPaymentsToCompany'] = sumPaymentsToCompany;
    map['countOrdersDelivered'] = countOrdersDelivered;
    map['sumInvoiceAmount'] = sumInvoiceAmount;
    map['deliveryCost'] = deliveryCost;
    map['amountYouOwn'] = amountYouOwn;
    map['remainingAmountForCompany'] = remainingAmountForCompany;
    map['salary'] = salary;
    map['bounce'] = bounce;
    map['kilometerBonus'] = kilometerBonus;
    map['netProfit'] = netProfit;
    map['total'] = total;
    return map;
  }
}

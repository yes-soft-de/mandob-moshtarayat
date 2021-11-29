import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class CaptainAccountBalanceResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  CaptainAccountBalanceResponse({this.statusCode, this.msg, this.data});

  CaptainAccountBalanceResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = [];
        json['Data'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      }
    } catch (e) {
      Logger()
          .error('Captain Account Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
}

class Data {
  num? sumPaymentsToCaptain;
  num? sumPaymentsFromCaptain;
  num? countOrdersDelivered;
  num? sumInvoiceAmount;
  num? deliveryCost;
  num? amountWithCaptain;
  num? remainingAmountForCompany;
  num? bounce;
  num? kilometerBonus;
  num? salary;
  num? netProfit;
  num? total;
  List<PaymentsFromCaptain>? paymentsToCaptain;
  List<PaymentsFromCaptain>? paymentsFromCaptain;

  Data(
      {this.sumPaymentsToCaptain,
      this.sumPaymentsFromCaptain,
      this.countOrdersDelivered,
      this.sumInvoiceAmount,
      this.deliveryCost,
      this.amountWithCaptain,
      this.remainingAmountForCompany,
      this.bounce,
      this.kilometerBonus,
      this.salary,
      this.netProfit,
      this.total,
      this.paymentsToCaptain,
      this.paymentsFromCaptain});

  Data.fromJson(dynamic json) {
    sumPaymentsToCaptain = json['sumPaymentsToCaptain'];
    sumPaymentsFromCaptain = json['sumPaymentsFromCaptain'];
    countOrdersDelivered = json['countOrdersDelivered'];
    sumInvoiceAmount = json['sumInvoiceAmount'];
    deliveryCost = json['deliveryCost'];
    amountWithCaptain = json['amountWithCaptain'];
    remainingAmountForCompany = json['remainingAmountForCompany'];
    bounce = json['bounce'];
    kilometerBonus = json['kilometerBonus'];
    salary = json['salary'];
    netProfit = json['NetProfit'];
    total = json['total'];
    if (json['paymentsToCaptain'] != null) {
      paymentsToCaptain = [];
      json['paymentsToCaptain'].forEach((v) {
        paymentsToCaptain?.add(PaymentsFromCaptain.fromJson(v));
      });
    }
    if (json['paymentsFromCaptain'] != null) {
      paymentsFromCaptain = [];
      json['paymentsFromCaptain'].forEach((v) {
        paymentsFromCaptain?.add(PaymentsFromCaptain.fromJson(v));
      });
    }
  }
}

class PaymentsFromCaptain {
  int? id;
  String? captainId;
  num? amount;
  Date? date;
  String? note;
  PaymentsFromCaptain(
      {this.id, this.captainId, this.amount, this.date, this.note});

  PaymentsFromCaptain.fromJson(dynamic json) {
    id = json['id'];
    captainId = json['captainId'];
    amount = json['amount'];
    note = json['note'];
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainId'] = captainId;
    map['amount'] = amount;
    if (date != null) {
      map['date'] = date?.toJson();
    }
    return map;
  }
}

class Date {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  Date({this.timezone, this.offset, this.timestamp});

  Date.fromJson(dynamic json) {
    timezone =
        json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (timezone != null) {
      map['timezone'] = timezone?.toJson();
    }
    map['offset'] = offset;
    map['timestamp'] = timestamp;
    return map;
  }
}

class Timezone {
  String? name;
  List<Transitions>? transitions;
  Location? location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(dynamic json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = [];
      json['transitions'].forEach((v) {
        transitions?.add(Transitions.fromJson(v));
      });
    }
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    if (transitions != null) {
      map['transitions'] = transitions?.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }
}

class Location {
  String? countryCode;
  int? latitude;
  int? longitude;
  String? comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(dynamic json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['country_code'] = countryCode;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['comments'] = comments;
    return map;
  }
}

class Transitions {
  int? ts;
  String? time;
  int? offset;
  bool? isdst;
  String? abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(dynamic json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['ts'] = ts;
    map['time'] = time;
    map['offset'] = offset;
    map['isdst'] = isdst;
    map['abbr'] = abbr;
    return map;
  }
}

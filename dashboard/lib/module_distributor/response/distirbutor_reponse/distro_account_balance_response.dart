import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class DistroAccountBalanceResponse {
  String? statusCode;
  String? msg;
  Data? data;

  DistroAccountBalanceResponse({this.statusCode, this.msg, this.data});

  DistroAccountBalanceResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data =  Data.fromJson(json['Data']);
      }
    } catch (e) {
      Logger()
          .error('Distro balance Account Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
}

class Data {
  num? sumPaymentToRepresentative;
  num? sumRepresentativeDue;
  num? totalRemainingPaymentsToRepresentative;
  List<PaymentsToRepresentative>? paymentsToRepresentative;

  Data(
      {this.sumRepresentativeDue,
      this.sumPaymentToRepresentative,
      this.totalRemainingPaymentsToRepresentative,
      this.paymentsToRepresentative});

  Data.fromJson(dynamic json) {
    sumPaymentToRepresentative = json['sumPaymentsToRepresentative'];
    sumRepresentativeDue = json['sumRepresentativeDue'];
    totalRemainingPaymentsToRepresentative = json['totalRemainingPaymentsToRepresentative'];
    if (json['paymentsToRepresentative'] != null) {
      paymentsToRepresentative = [];
      json['paymentsToRepresentative'].forEach((v) {
        paymentsToRepresentative?.add(PaymentsToRepresentative.fromJson(v));
      });
    }
  }
}

class PaymentsToRepresentative{
  int? id;
//  String? captainId;
  num? amount;
  Date? date;
  String? note;
  PaymentsToRepresentative(
      {this.id, this.amount, this.date, this.note});

  PaymentsToRepresentative.fromJson(dynamic json) {
    id = json['id'];
//    captainId = json['captainId'];
    amount = json['amount'];
    note = json['note'];
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
//    map['captainId'] = captainId;
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

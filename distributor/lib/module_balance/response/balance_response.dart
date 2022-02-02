

import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class BalanceResponse {
  String? statusCode;
  String? msg;
   Data? data;

  BalanceResponse({
      this.statusCode, 
      this.msg, 
      this.data});

  BalanceResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = Data.fromJson(json['Data']);
      }
    } catch (e) {
      statusCode = '-1';
      Logger().error(
          'Balance  Response', e.toString(), StackTrace.current);
    }
  }}

class Data {
  num? sumPaymentToRepresentative;
  num? sumRepresentativeDue;
  num? totalRemainingPaymentsToRepresentative;
  List<Amount>? paymentsToRepresentative;
  Data({
      this.sumPaymentToRepresentative,
      this.sumRepresentativeDue,
      this.totalRemainingPaymentsToRepresentative,this.paymentsToRepresentative
  });

  Data.fromJson(dynamic json) {
    sumPaymentToRepresentative = json['sumPaymentsToRepresentative'];
    sumRepresentativeDue = json['sumRepresentativeDue'];
    totalRemainingPaymentsToRepresentative = json['totalRemainingPaymentsToRepresentative'];
    if (json['paymentsToRepresentative'] != null) {
      paymentsToRepresentative = [];
      json['paymentsToRepresentative'].forEach((v) {
        paymentsToRepresentative?.add(Amount.fromJson(v));
      });
    }
  }
}

class Amount{
  int? id;
  num? amount;
  String? note;
  CreatedAt? date;

  Amount({this.id, this.amount, this.note, this.date});

  Amount.fromJson(dynamic json) {
    id = json['id'];
    amount = json['amount'];
    date = json['date'] != null
        ? CreatedAt.fromJson(json['date'])
        : null;
    note=json['note'];
  }

}
class CreatedAt {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  CreatedAt({this.timezone, this.offset, this.timestamp});

  CreatedAt.fromJson(dynamic json) {
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
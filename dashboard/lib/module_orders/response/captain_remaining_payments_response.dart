import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class CaptainRemainingPaymentsResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CaptainRemainingPaymentsResponse({this.statusCode, this.msg, this.data});

  CaptainRemainingPaymentsResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger().error(
          'Captain Remaining Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  num? totalAmountForCompany;
  List<Captains>? captains;

  Data({this.totalAmountForCompany, this.captains});

  Data.fromJson(dynamic json) {
    totalAmountForCompany = json['totalAmountForCompany'];
    if (json['captains'] != null) {
      captains = [];
      json['captains'].forEach((v) {
        captains?.add(Captains.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['totalAmountForCompany'] = totalAmountForCompany;
    if (captains != null) {
      map['captains'] = captains?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Captains {
  int? id;
  String? captainID;
  String? captainName;
  String? roomID;
  String? image;
  String? phone;
  num? remainingAmountForCompany;

  Captains(
      {this.id,
      this.captainID,
      this.captainName,
      this.roomID,
      this.image,
      this.phone,
      this.remainingAmountForCompany});

  Captains.fromJson(dynamic json) {
    id = json['id'];
    captainID = json['captainID'];
    captainName = json['captainName'];
    roomID = json['roomID'];
    image = json['image'];
    phone = json['phone'];
    remainingAmountForCompany = json['remainingAmountForCompany'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainID'] = captainID;
    map['captainName'] = captainName;
    map['roomID'] = roomID;
    map['image'] = image;
    map['phone'] = phone;
    map['remainingAmountForCompany'] = remainingAmountForCompany;
    return map;
  }
}

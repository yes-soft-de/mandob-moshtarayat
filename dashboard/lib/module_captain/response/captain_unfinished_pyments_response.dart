import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class CaptainUnfinishedPaymentsResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  CaptainUnfinishedPaymentsResponse({this.statusCode, this.msg, this.data});

  CaptainUnfinishedPaymentsResponse.fromJson(dynamic json) {
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
      Logger().error('Payment List Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  int? id;
  String? captainID;
  String? captainName;
  String? roomID;
  String? image;
  String? phone;
  num? remainingAmountForCaptain;

  Data(
      {this.id,
      this.captainID,
      this.captainName,
      this.roomID,
      this.image,
      this.phone,
      this.remainingAmountForCaptain});

  Data.fromJson(dynamic json) {
    id = json['id'];
    captainID = json['captainID'];
    captainName = json['captainName'];
    roomID = json['roomID'];
    image = json['image'];
    phone = json['phone'];
    remainingAmountForCaptain = json['remainingAmountForCaptain'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainID'] = captainID;
    map['captainName'] = captainName;
    map['roomID'] = roomID;
    map['image'] = image;
    map['phone'] = phone;
    map['remainingAmountForCaptain'] = remainingAmountForCaptain;
    return map;
  }
}

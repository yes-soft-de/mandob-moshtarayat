import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class ProfileResponse {
  String? statusCode;
  String? msg;
  Data? data;

  ProfileResponse({this.statusCode, this.msg, this.data});

  ProfileResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger().error('Profile Response', '${e.toString()}', StackTrace.current);
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
  int? id;
  String? clientID;
  String? clientName;
  String? roomID;
  String? phone;
  String? image;
  dynamic location;
  String? taxNumber;
  String? nationalAddress;
  String? recordNumber;

  Data(
      {this.id,
      this.clientID,
      this.clientName,
      this.roomID,
      this.phone,
      this.image,
      this.location,
      this.nationalAddress,
      this.recordNumber,
      this.taxNumber
      });

  Data.fromJson(dynamic json) {
    id = json['id'];
    clientID = json['clientID'];
    clientName = json['clientName'];
    roomID = json['roomID'];
    phone = json['phone'];
    image = json['image'];
    recordNumber = json['recordNumber'];
    nationalAddress = json['nationalAddress'];
    taxNumber= json['taxNumber'];
    if (json['location'] is String) {
      location = json['location'];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['clientID'] = clientID;
    map['clientName'] = clientName;
    map['roomID'] = roomID;
    map['phone'] = phone;
    map['image'] = image;
    map['location'] = location;
    return map;
  }
}

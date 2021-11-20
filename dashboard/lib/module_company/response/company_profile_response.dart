import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class CompanyProfileResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  CompanyProfileResponse({this.statusCode, this.msg, this.data});

  CompanyProfileResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    try {} catch (e) {
      Logger().error('Company Response', e.toString(), StackTrace.current);
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
  String? phone;
  String? phone2;
  String? whatspp;
  String? fax;
  String? bank;
  String? stc;
  String? email;
  String? roomID;

  Data(
      {this.id,
      this.phone,
      this.phone2,
      this.whatspp,
      this.fax,
      this.bank,
      this.stc,
      this.email,
      this.roomID});

  Data.fromJson(dynamic json) {
    id = json['id'];
    phone = json['phone'];
    phone2 = json['phone2'];
    whatspp = json['whatsapp'];
    fax = json['fax'];
    bank = json['bank'];
    stc = json['stc'];
    email = json['email'];
    roomID = json['roomID'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['phone'] = phone;
    map['phone2'] = phone2;
    map['whatsapp'] = whatspp;
    map['fax'] = fax;
    map['bank'] = bank;
    map['stc'] = stc;
    map['email'] = email;
    map['roomID'] = roomID;
    return map;
  }
}



import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class ProfileResponse {
  String? statusCode;
  String? msg;
  Data? data;

  ProfileResponse({
      this.statusCode, 
      this.msg, 
      this.data});

  ProfileResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger().error('Mandob Profile',e.toString(),StackTrace.current);
      statusCode = '-1';
    }
  }

}

class Data {
  int? id;
  String? mandobName;
  String? status;

  String? bankName;
  String? bankAccountNumber;
  String? stcPay;


  String? phone;
  ImageUrl? imageURL;

  String? roomID;
  String? mandobID;
  num? age;


  Data({
      this.id,
    this.mandobName,
      this.status,
    this.bankAccountNumber,this.bankName,this.stcPay,
this.mandobID,

      this.phone,
      this.imageURL,
    this.age,this.roomID

  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    mandobName = json['mandobName'];

    phone = json['phone'];
    imageURL = json['image'] != null ?ImageUrl.fromJson(json['image']) : null;
    bankName = json['bankName'];
    bankAccountNumber = json['bankAccountNumber'];
    stcPay = json['stcPay'];
    age = json['age'];
    roomID = json['roomID'];
    status = json['status'];
    mandobID = json['mandobID'];
  }
}

class ImageUrl {
  String? image;
  String? imageURL;
  String? baseURL;
  ImageUrl({
    this.image,
    this.imageURL,this.baseURL
  });

  ImageUrl.fromJson(dynamic json) {
    image = json['image'];
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
  }
}
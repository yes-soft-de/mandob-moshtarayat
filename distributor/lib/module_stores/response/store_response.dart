

import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class StoreResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  StoreResponse({
      this.statusCode, 
      this.msg, 
      this.data});

  StoreResponse.fromJson(dynamic json) {
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
      statusCode = '-1';
      Logger().error(
          'Stores profile Response', e.toString(), StackTrace.current);
    }
  }}

class Data {
  int? id;
  String? storeOwnerName;
  String? status;


  String? phone;
  ImageUrl? imageURL;

  Data({
      this.id,
      this.storeOwnerName,
      this.status,
      this.phone,
      this.imageURL,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];

    phone = json['phone'];
    imageURL = json['image'] != null ?ImageUrl.fromJson(json['image']) : null;
    status = json['status'];
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
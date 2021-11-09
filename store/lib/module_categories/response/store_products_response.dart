import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class StoreProductsResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  StoreProductsResponse({
      this.statusCode, 
      this.msg, 
      this.data});

  StoreProductsResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = [];
        json['Data'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      }
    }
    catch(e){
      Logger().error('Store Products Response',e.toString(), StackTrace.current);
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
  String? productName;
  String? productImage;
  num? productPrice;
  int? storeOwnerProfileID;
  int? storeProductCategoryID;

  Data({
      this.id, 
      this.productName, 
      this.productImage, 
      this.productPrice, 
      this.storeOwnerProfileID, 
      this.storeProductCategoryID});

  Data.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    storeProductCategoryID = json['storeProductCategoryID'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['storeProductCategoryID'] = storeProductCategoryID;
    return map;
  }

}
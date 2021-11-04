import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class ProductsByCategory {
  String? statusCode;
  String? msg;
  List<Data>? data;

  ProductsByCategory({
    this.statusCode,
    this.msg,
    this.data,
  });

  ProductsByCategory.fromJson(dynamic json) {
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
      Logger().error('products by category response', '${e.toString()}',
          StackTrace.current);
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
  String? productName;
  String? productImage;
  double? productPrice;
  int? storeOwnerProfileID;
  int? productCategoryID;

  Data(
      {this.id,
      this.productName,
      this.productImage,
      this.productPrice,
      this.storeOwnerProfileID,
      this.productCategoryID});

  Data.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice']?.toDouble();
    storeOwnerProfileID = json['storeOwnerProfileID'];
    productCategoryID = json['storeProductCategoryID'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['ProductCategoryID'] = productCategoryID;
    return map;
  }
}

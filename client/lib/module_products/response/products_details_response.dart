import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class ProductsDetailsResponse {
  ProductsDetailsResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  ProductsDetailsResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger().error('Products Response', e.toString(), StackTrace.current);
    }
  }
  String? statusCode;
  String? msg;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.productName,
    this.productImage,
    this.productPrice,
    this.storeOwnerProfileID,
    this.storeProductCategoryID,
    this.storeOwnerName,
    this.image,
    this.phone,
    this.location,
    this.branchName,
    this.deliveryCost,
    this.discount,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    storeProductCategoryID = json['storeProductCategoryID'];
    storeOwnerName = json['storeOwnerName'];
    image = json['image'];
    phone = json['phone'];
    branchName = json['branchName'];
    deliveryCost = json['deliveryCost'];
    discount = json['discount'];
    description = json['description'];
    rate = json['rate'];
    soldCount = json['soldCount']?.toString();
  }

  int? id;
  String? productName;
  String? productImage;
  num? productPrice;
  int? storeOwnerProfileID;
  int? storeProductCategoryID;
  String? storeOwnerName;
  String? image;
  String? phone;
  List<dynamic>? location;
  String? branchName;
  dynamic deliveryCost;
  String? discount;
  String? description;
  String? rate;
  String? soldCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['storeProductCategoryID'] = storeProductCategoryID;
    map['storeOwnerName'] = storeOwnerName;
    map['image'] = image;
    map['phone'] = phone;
    if (location != null) {
      map['location'] = location?.map((v) => v.toJson()).toList();
    }
    map['branchName'] = branchName;
    map['deliveryCost'] = deliveryCost;
    map['discount'] = discount;
    return map;
  }
}

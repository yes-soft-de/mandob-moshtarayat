import 'package:mandob_moshtarayat/module_stores/response/rating.dart';
import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class SearchResponse {
  String? statusCode;
  String? msg;
  Data? data;

  SearchResponse({this.statusCode, this.msg, this.data});

  SearchResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      statusCode = '-1';
      Logger().error('Search Response', e.toString(), StackTrace.current);
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
  List<Stores>? stores;
  List<Products>? products;

  Data({this.stores, this.products});

  Data.fromJson(dynamic json) {
    if (json['stores'] != null) {
      stores = [];
      json['stores'].forEach((v) {
        stores?.add(Stores.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (stores != null) {
      map['stores'] = stores?.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Products {
  int? id;
  String? productName;
  String? productImage;
  int? storeProductCategoryID;
  num? productPrice;
  int? storeOwnerProfileID;
  String? storeOwnerName;
  num? deliveryCost;
  String? storeImage;

  Products(
      {this.id,
      this.productName,
      this.productImage,
      this.storeProductCategoryID,
      this.productPrice,
      this.storeOwnerProfileID,
      this.storeOwnerName,
      this.deliveryCost,
      this.storeImage});

  Products.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['productImage'];
    storeProductCategoryID = json['storeProductCategoryID'];
    productPrice = json['productPrice'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    storeOwnerName = json['storeOwnerName'];
    deliveryCost = json['deliveryCost'];
    storeImage = json['storeImage'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['storeProductCategoryID'] = storeProductCategoryID;
    map['productPrice'] = productPrice;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['storeOwnerName'] = storeOwnerName;
    map['deliveryCost'] = deliveryCost;
    map['storeImage'] = storeImage;
    return map;
  }
}

class Stores {
  int? id;
  String? storeOwnerName;
  String? image;
  String? phone;
  int? storeCategoryId;
  bool? privateOrders;
  bool? hasProducts;
  Rating? rating;

  Stores(
      {this.id,
      this.storeOwnerName,
      this.image,
      this.phone,
      this.storeCategoryId,
      this.privateOrders,
      this.hasProducts,
      this.rating});

  Stores.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    image = json['image'];
    phone = json['phone'];
    storeCategoryId = json['storeCategoryId'];
    privateOrders = json['privateOrders'];
    hasProducts = json['hasProducts'];
    rating = json['rate'] != null ? Rating.fromJson(json['rate']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerName'] = storeOwnerName;
    map['image'] = image;
    map['phone'] = phone;
    map['storeCategoryId'] = storeCategoryId;
    map['privateOrders'] = privateOrders;
    map['hasProducts'] = hasProducts;
    return map;
  }
}

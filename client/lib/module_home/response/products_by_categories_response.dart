import 'package:mandob_moshtarayat/module_home/response/store_response/store_response.dart';
import 'package:mandob_moshtarayat/utils/response/cost_details_response/cost_details_response.dart';

class ProductsByCategoriesResponse {
  ProductsByCategoriesResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  ProductsByCategoriesResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  String? statusCode;
  String? msg;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data(
      {this.id,
      this.productName,
      this.productPrice,
      this.storeOwnerProfileID,
      this.storeProductCategoryID,
      this.image,
      this.discount,
      this.rate,
      this.soldCount,
      this.description});

  Data.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    storeProductCategoryID = json['storeProductCategoryID'];
    discount = json['discount']?.toString();
    rate = json['rate'];
    soldCount = json['soldCount']?.toString();
    description = json['description'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    store =
        json['store'] != null ? StoreResponse.fromJson(json['store']) : null;
    costDetailsResponse = CostDetailsResponse.fromJson(json);
  }

  int? id;
  String? productName;
  num? productPrice;
  int? storeOwnerProfileID;
  int? storeProductCategoryID;
  Image? image;
  String? discount;
  String? rate;
  String? soldCount;
  String? description;
  StoreResponse? store;
  CostDetailsResponse? costDetailsResponse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productPrice'] = productPrice;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['storeProductCategoryID'] = storeProductCategoryID;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    return map;
  }
}

class Image {
  Image({
    this.imageURL,
    this.image,
    this.baseURL,
  });

  Image.fromJson(dynamic json) {
    imageURL = json['imageURL'];
    image = json['image'];
    baseURL = json['baseURL'];
    if (imageURL == null) {
      image = null;
      baseURL = null;
    }
  }

  String? imageURL;
  String? image;
  String? baseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageURL'] = imageURL;
    map['image'] = image;
    map['baseURL'] = baseURL;
    return map;
  }
}

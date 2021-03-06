import 'package:mandob_moshtarayat_dashboad/module_categories/response/cost_details_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class StoreProductsResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  StoreProductsResponse({this.statusCode, this.msg, this.data});

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
    } catch (e) {
      Logger()
          .error('Store Products Response', e.toString(), StackTrace.current);
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
  int? storeOwnerProfileID;
  String? productName;
  ImageUrl? productImage;
  num? productPrice;
  num? discount;
  int? storeProductCategoryID;
  num? commission;
  bool? isCommission;
  CostDetailsResponse? costDetails;
  Data(
      {this.id,
      this.storeOwnerProfileID,
      this.productName,
      this.productImage,
      this.productPrice,
      this.discount,
      this.storeProductCategoryID,
      this.commission,
      this.costDetails,
      this.isCommission});

  Data.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage =
        json['image'] != null ? ImageUrl.fromJson(json['image']) : null;
    productPrice = json['productPrice'];
    discount = json['discount'];
    storeProductCategoryID = json['storeProductCategoryID'];
    commission = json['commission'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    isCommission = json['isCommission'] ?? false;
    costDetails = json['costDetails'] != null
        ? CostDetailsResponse.fromJson(json['costDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['discount'] = discount;
    map['storeProductCategoryID'] = storeProductCategoryID;
    return map;
  }
}

class ImageUrl {
  String? image;
  String? imageURL;
  String? baseURL;
  ImageUrl({this.image, this.imageURL, this.baseURL});

  ImageUrl.fromJson(dynamic json) {
    image = json['image'];
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
  }
}

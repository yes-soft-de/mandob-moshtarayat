import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class ProductsResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  ProductsResponse({this.statusCode, this.msg, this.data});

  ProductsResponse.fromJson(dynamic json) {
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
      Logger().error('Products Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
}

class Data {
  int? id;
  String? productName;
  String? productImage;
  double? productPrice;
  int? storeOwnerProfileID;
  int? productCategoryID;
  String? storeOwnerName;
  int? storeOwnerID;
  String? image;
  dynamic phone;
  dynamic location;
  dynamic branchName;
  dynamic city;
  double? deliveryCost;
  Data(
      {this.id,
      this.productName,
      this.productImage,
      this.productPrice,
      this.storeOwnerProfileID,
      this.productCategoryID,
      this.storeOwnerName,
      this.storeOwnerID,
      this.image,
      this.phone,
      this.location,
      this.branchName,
      this.city,
      this.deliveryCost});

  Data.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice']?.toDouble();
    storeOwnerProfileID = json['storeOwnerProfileID'];
    productCategoryID = json['ProductCategoryID'];
    storeOwnerName = json['storeOwnerName'];
    storeOwnerID = json['storeOwnerID'];
    image = json['image'];
    phone = json['phone'];
    location = json['location'];
    branchName = json['branchName'];
    city = json['city'];
    deliveryCost = json['deliveryCost']?.toDouble();
  }
}

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
  String? productStatus;
  ImageUrl? productImage;
  num? productPrice;
  num? discount;
  num? productQuantity;
  int? storeProductCategoryID;
  bool? isLevelOne;
  bool? isLevelTwo;
  CategoryLink? categoryLink;

  Data({
      this.id, 
      this.productName,
    this.productStatus,
      this.productImage, 
      this.productPrice, 
      this.discount,
    this.productQuantity,
    this.isLevelOne,this.isLevelTwo,
      this.storeProductCategoryID ,this.categoryLink});

  Data.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['image'] != null ?ImageUrl.fromJson(json['image']) : null;
    productPrice = json['productPrice'];
    productQuantity = json['productQuantity'];
    discount = json['discount'];
    storeProductCategoryID = json['storeProductCategoryID'];
    isLevelOne = json['isLevel1'];
    isLevelTwo = json['isLevel2'];
    productStatus = json['status'];
    categoryLink = json['categoryLink'] != null ? CategoryLink.fromJson(json['categoryLink']) : CategoryLink();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['discount'] = discount;
    map['productQuantity'] = productQuantity;
    map['storeProductCategoryID'] = storeProductCategoryID;
    return map;
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
    image = json['image']?? '';
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
  }
}
class CategoryLink {
  int? subCategoryLevelOneID;
  int? subCategoryLevelTwoID;

  CategoryLink({
    this.subCategoryLevelTwoID,
    this.subCategoryLevelOneID
  });

  CategoryLink.fromJson(dynamic json) {
    subCategoryLevelTwoID = json['subCategoryLevelTwoID']?? '';
    subCategoryLevelOneID = json['subCategoryLevelOneID'];
  }
}
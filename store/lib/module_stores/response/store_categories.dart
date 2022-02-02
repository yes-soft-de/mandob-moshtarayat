import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class StoreAndCategoriesResponse {
  String? statusCode;
  String? msg;
  Data? data;

  StoreAndCategoriesResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  StoreAndCategoriesResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = Data.fromJson(json['Data']);
      }
    } catch (e) {
      Logger().error(
          'Store Categories Login Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
}
class Data {
  List<StoreCategoriesData>? categories;
  List<StoresData>? stores;

  Data({this.categories, this.stores});

  Data.fromJson(dynamic json) {
    try {
      if (json['stores'] != null) {
        stores = [];
        json['stores'].forEach((v) {
          stores?.add(StoresData.fromJson(v));
        });
      }
      if (json['categories'] != null) {
        categories = [];
        json['categories'].forEach((v) {
          categories?.add(StoreCategoriesData.fromJson(v));
        });
      }
    } catch (e) {
      Logger().error(
          'Store Categories Login Response', e.toString(), StackTrace.current);
    }
  }
}

class StoreCategoriesData {
  int? id;
  String? storeCategoryName;
  Image? image;

  StoreCategoriesData({this.id, this.storeCategoryName,  this.image});

  StoreCategoriesData.fromJson(dynamic json) {
    id = json['id'];
    storeCategoryName = json['storeCategoryName'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }
}
class StoresData {
  int? id;
  String? storeOwnerName;
  Image? image;

  StoresData(
      {this.id,
        this.storeOwnerName,
        this.image,
        });

  StoresData.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerName'] = storeOwnerName;
    map['image'] = image;
    return map;
  }
}
class Image {
  String? imageURL;
  String? baseURL;
  String? image;

  Image({this.imageURL, this.baseURL, this.image});

  Image.fromJson(dynamic json) {
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
    image = json['image'];
  }
}

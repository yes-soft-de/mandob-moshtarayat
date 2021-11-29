import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class StoreCategoriesResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  StoreCategoriesResponse({this.statusCode, this.msg, this.data});

  StoreCategoriesResponse.fromJson(dynamic json) {
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
          .error('StoreGetegoriesResponse', e.toString(), StackTrace.current);
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
  String? storeCategoryName;
  String? description;
  Image? image;

  Data({this.id, this.storeCategoryName, this.description, this.image});

  Data.fromJson(dynamic json) {
    id = json['id'];
    storeCategoryName = json['storeCategoryName'];
    description = json['description'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeCategoryName'] = storeCategoryName;
    map['description'] = description;
    map['image'] = image;
    return map;
  }
}
class Image {
  Image({
    this.imageURL,
    this.image,
    this.baseURL,});

  Image.fromJson(dynamic json) {
    imageURL = json['imageURL'];
    image = json['image'];
    baseURL = json['baseURL'];
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

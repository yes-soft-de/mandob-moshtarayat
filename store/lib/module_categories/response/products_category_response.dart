import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class ProductsCategoryResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  ProductsCategoryResponse({this.statusCode, this.msg, this.data});

  ProductsCategoryResponse.fromJson(dynamic json) {
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
      statusCode = '-1';
      Logger().error(
          'Products Category Response', e.toString(), StackTrace.current);
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
  String? productCategoryName;

  Data({this.id, this.productCategoryName});

  Data.fromJson(dynamic json) {
    id = json['id'];
    productCategoryName = json['productCategoryName'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['productCategoryName'] = productCategoryName;
    return map;
  }
}

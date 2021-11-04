import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class ProductsCategory {
  String? statusCode;
  String? msg;
  List<Data>? data;
  ProductsCategory({this.statusCode, this.msg, this.data});

  ProductsCategory.fromJson(dynamic json) {
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
      Logger().error(
          'products category response', '${e.toString()}', StackTrace.current);
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

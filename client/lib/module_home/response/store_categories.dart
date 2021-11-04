import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class StoreCategoriesResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  StoreCategoriesResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

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
      Logger().error(
          'Store Categories Login Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
}

class Data {
  int? id;
  String? storeCategoryName;
  String? description;
  String? image;

  Data({this.id, this.storeCategoryName, this.description, this.image});

  Data.fromJson(dynamic json) {
    id = json['id'];
    storeCategoryName = json['storeCategoryName'];
    description = json['description'];
    image = json['image'];
  }
}

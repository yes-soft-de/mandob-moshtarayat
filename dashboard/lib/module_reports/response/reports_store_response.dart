import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_categories_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class ReportsStoreResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  ReportsStoreResponse({this.statusCode, this.msg, this.data});

  ReportsStoreResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    try {} catch (e) {
      Logger()
          .error('Reports Store Response', e.toString(), StackTrace.current);
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
  int? storeOwnerProfileID;
  int? countOrdersInMonth;
  String? storeOwnerName;
  Image? image;

  Data(
      {this.storeOwnerProfileID,
      this.countOrdersInMonth,
      this.storeOwnerName,
      this.image});

  Data.fromJson(dynamic json) {
    storeOwnerProfileID = json['storeOwnerProfileID'];
    countOrdersInMonth = json['countOrdersInMonth'];
    storeOwnerName = json['storeOwnerName'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['countOrdersInMonth'] = countOrdersInMonth;
    map['storeOwnerName'] = storeOwnerName;
    map['image'] = image;
    return map;
  }
}

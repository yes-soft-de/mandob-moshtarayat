import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class ReportsProductsResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  ReportsProductsResponse({this.statusCode, this.msg, this.data});

  ReportsProductsResponse.fromJson(dynamic json) {
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
          .error('Reports Products Response', e.toString(), StackTrace.current);
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
  int? productID;
  int? countOrdersInMonth;
  String? productName;
  String? productImage;

  Data(
      {this.productID,
      this.countOrdersInMonth,
      this.productName,
      this.productImage});

  Data.fromJson(dynamic json) {
    productID = json['productID'];
    countOrdersInMonth = json['countOrdersInMonth'];
    productName = json['productName'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productID'] = productID;
    map['countOrdersInMonth'] = countOrdersInMonth;
    map['productName'] = productName;
    map['productImage'] = productImage;
    return map;
  }
}

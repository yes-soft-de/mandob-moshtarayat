import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class CompanyDeliveryPriceResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CompanyDeliveryPriceResponse({this.statusCode, this.msg, this.data});

  CompanyDeliveryPriceResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger()
          .error('Company Delivery Price', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  int? id;
  num? deliveryCost;

  Data({this.id, this.deliveryCost});

  Data.fromJson(dynamic json) {
    id = json['id'];
    deliveryCost = json['deliveryCost'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['deliveryCost'] = deliveryCost;
    return map;
  }
}

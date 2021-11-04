import 'package:mandob_moshtarayat/utils/logger/logger.dart';
import 'package:validators/sanitizers.dart';

class BestStoreResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  BestStoreResponse({this.statusCode, this.msg, this.data});

  BestStoreResponse.fromJson(dynamic json) {
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
          .error('best store response', '${e.toString()}', StackTrace.current);
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
  String? storeOwnerName;
  String? image;
  dynamic phone;
  dynamic location;
  double? deliveryCost;
  bool? privateOrders;
  bool? hasProducts;
  Data(
      {this.id,
      this.storeOwnerName,
      this.image,
      this.phone,
      this.location,
      this.deliveryCost,
      this.hasProducts,
      this.privateOrders});

  Data.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    image = json['image'];
    phone = json['phone'];
    location = json['location'];
    deliveryCost = json['deliveryCost']?.toDouble();
    privateOrders = json['privateOrders'];
    hasProducts = json['hasProducts'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerName'] = storeOwnerName;
    map['image'] = image;
    map['phone'] = phone;
    map['location'] = location;
    return map;
  }
}

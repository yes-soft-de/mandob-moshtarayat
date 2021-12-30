import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_categories_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class StoresResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  StoresResponse({this.statusCode, this.msg, this.data});

  StoresResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    try {} catch (e) {
      Logger().error('stores response', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
  }
}

class Data {
  int? id;
  String? storeOwnerName;
  Image? image;
  dynamic phone;
  dynamic location;
  double? deliveryCost;
  bool? privateOrders;
  bool? hasProducts;
  num? categoryId;
  Date? closingTime;
  Date? openingTime;
  String? status;
  String? imageUrl;
  double? commission;

  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  Data({
    this.id,
    this.storeOwnerName,
    this.image,
    this.phone,
    this.location,
    this.deliveryCost,
    this.privateOrders,
    this.hasProducts,
    this.categoryId,
    this.closingTime,
    this.openingTime,
    this.status,
    this.imageUrl,
    this.commission,
    this.bankAccountNumber,
    this.bankName,
    this.stcPay,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageURL'];
    storeOwnerName = json['storeOwnerName'];
    categoryId = json['storeCategoryId'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    phone = json['phone'];
    location = json['location'];
    deliveryCost = json['deliveryCost']?.toDouble();
    privateOrders = json['privateOrders'];
    hasProducts = json['hasProducts'];
    closingTime =
        json['closingTime'] != null ? Date.fromJson(json['closingTime']) : null;
    openingTime =
        json['openingTime'] != null ? Date.fromJson(json['openingTime']) : null;
    status = json['status'];
    commission = json['commission']?.toDouble();
    bankName = json['bankName'];
    bankAccountNumber = json['bankAccountNumber'];
    stcPay = json['stcPay'];
  }
}

class GeoJson {
  num? lat;
  num? long;

  GeoJson({this.lat, this.long});

  GeoJson.fromJson(dynamic json) {
    lat = json['lat'];
    long = json['lon'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['lat'] = lat;
    data['lon'] = long;

    return data;
  }
}

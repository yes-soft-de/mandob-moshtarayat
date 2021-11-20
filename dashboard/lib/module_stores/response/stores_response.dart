import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class StoresResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  StoresResponse({this.statusCode, this.msg, this.data});

  StoresResponse.fromJson(dynamic json) {
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
      Logger().error('stores response', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
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
  num? categoryId;
  Date? closingTime;
  Date? openingTime;
  String? status;
  String? imageUrl;
  Data(
      {this.id,
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
      this.imageUrl
      });

  Data.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageURL'];
    storeOwnerName = json['storeOwnerName'];
    categoryId = json['storeCategoryId'];
    image = json['image'];
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

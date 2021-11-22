import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class StoresFilterResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  StoresFilterResponse({this.statusCode, this.msg, this.data});

  StoresFilterResponse.fromJson(dynamic json) {
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
          .error('Stores Filter Response', e.toString(), StackTrace.current);
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
  int? storeOwnerID;
  String? image;
  String? status;
  dynamic roomID;
  int? storeCategoryId;
  String? phone;
  dynamic isBest;
  bool? privateOrders;
  bool? hasProducts;

  Data(
      {this.id,
      this.storeOwnerName,
      this.storeOwnerID,
      this.image,
      this.status,
      this.roomID,
      this.storeCategoryId,
      this.phone,
      this.isBest,
      this.privateOrders,
      this.hasProducts});

  Data.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    storeOwnerID = json['storeOwnerID'];
    image = json['image'];
    status = json['status'];
    roomID = json['roomID'];
    storeCategoryId = json['storeCategoryId'];
    phone = json['phone'];
    isBest = json['is_best'];
    privateOrders = json['privateOrders'];
    hasProducts = json['hasProducts'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerName'] = storeOwnerName;
    map['storeOwnerID'] = storeOwnerID;
    map['image'] = image;
    map['status'] = status;
    map['roomID'] = roomID;
    map['storeCategoryId'] = storeCategoryId;
    map['phone'] = phone;
    map['is_best'] = isBest;
    map['privateOrders'] = privateOrders;
    map['hasProducts'] = hasProducts;
    return map;
  }
}

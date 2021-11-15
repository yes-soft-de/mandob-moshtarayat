import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class CaptainFilterResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CaptainFilterResponse({this.statusCode, this.msg, this.data});

  CaptainFilterResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger()
          .error('Captain Filter Response', e.toString(), StackTrace.current);
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
  List<Stores>? stores;

  Data({this.stores});

  Data.fromJson(dynamic json) {
    if (json['captains'] != null) {
      stores = [];
      json['captains'].forEach((v) {
        stores?.add(Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (stores != null) {
      map['stores'] = stores?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Stores {
  int? id;
  String? captainID;
  String? captainName;
  String? image;

  Stores({this.id, this.captainID, this.captainName, this.image});

  Stores.fromJson(dynamic json) {
    id = json['id'];
    captainID = json['captainID'];
    captainName = json['captainName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['captainID'] = captainID;
    map['captainName'] = captainName;
    map['image'] = image;
    return map;
  }
}

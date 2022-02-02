import 'package:mandob_moshtarayat_captain/module_orders/response/orders/geojson.dart';
import 'package:mandob_moshtarayat_captain/utils/logger/logger.dart';

class OrdersResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  OrdersResponse({this.statusCode, this.msg, this.data});

  OrdersResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = [];
        if (json['Data'] is List) {
          json['Data'].forEach((v) {
            data?.add(Data.fromJson(v));
          });
        }
      }
    } catch (e) {
      Logger().error('Order Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
}

class Data {
  int? id;
  GeoJson? source;
  DeliveryDate? deliveryDate;
  String? payment;
  String? orderNumber;
  String? detail;
  int? storeOwnerProfileID;
  String? storeOwnerName;
  List<Branches>? branches;
  String? image;
  double? deliveryCost;
  double? orderCost;
  int? orderType;

  Data(
      {this.id,
      this.source,
      this.deliveryDate,
      this.payment,
      this.orderNumber,
      this.detail,
      this.storeOwnerProfileID,
      this.storeOwnerName,
      this.branches,
      this.image,
      this.deliveryCost,
      this.orderCost,
      this.orderType});

  Data.fromJson(dynamic json) {
    id = json['id'];
    if (json['source'] != null) {
      var src = json['source'];
      if (src is Map) {
        source = GeoJson.fromJson(src);
      }
    }
    deliveryDate = json['deliveryDate'] != null
        ? DeliveryDate.fromJson(json['deliveryDate'])
        : null;
    payment = json['payment'];
    orderNumber = json['orderNumber'];
    detail = json['detail'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    storeOwnerName = json['storeOwnerName'];
    if (json['branches'] != null) {
      branches = [];
      json['branches'].forEach((v) {
        branches?.add(Branches.fromJson(v));
      });
    }
    image = json['image'];
    deliveryCost = json['deliveryCost']?.toDouble();
    orderCost = json['orderCost']?.toDouble();
    orderType = json['orderType'];
  }
}

class Branches {
  int? id;
  int? storeOwnerProfileID;
  GeoJson? location;
  String? city;
  String? branchName;
  bool? free;
  String? storeOwnerName;
  bool? isActive;
  double? distance;
  Branches(
      {this.id,
      this.storeOwnerProfileID,
      this.location,
      this.city,
      this.branchName,
      this.free,
      this.storeOwnerName,
      this.isActive,
      this.distance = 0});

  Branches.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    if (json['location'] != null) {
      var loc = json['location'];
      if (loc is Map) {
        location = GeoJson.fromJson(json['location']);
      }
    }
    city = json['city'];
    branchName = json['branchName'];
    free = json['free'];
    storeOwnerName = json['storeOwnerName'];
    isActive = json['isActive'];
  }
}

class DeliveryDate {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  DeliveryDate({this.timezone, this.offset, this.timestamp});

  DeliveryDate.fromJson(dynamic json) {
    timezone =
        json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (timezone != null) {
      map['timezone'] = timezone?.toJson();
    }
    map['offset'] = offset;
    map['timestamp'] = timestamp;
    return map;
  }
}

class Timezone {
  String? name;
  List<Transitions>? transitions;
  Location? location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(dynamic json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = [];
      json['transitions'].forEach((v) {
        transitions?.add(Transitions.fromJson(v));
      });
    }
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    if (transitions != null) {
      map['transitions'] = transitions?.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }
}

class Location {
  String? countryCode;
  int? latitude;
  int? longitude;
  String? comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(dynamic json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['country_code'] = countryCode;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['comments'] = comments;
    return map;
  }
}

class Transitions {
  int? ts;
  String? time;
  int? offset;
  bool? isdst;
  String? abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(dynamic json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['ts'] = ts;
    map['time'] = time;
    map['offset'] = offset;
    map['isdst'] = isdst;
    map['abbr'] = abbr;
    return map;
  }
}

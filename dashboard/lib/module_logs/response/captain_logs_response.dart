import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class CaptainLogsResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CaptainLogsResponse({this.statusCode, this.msg, this.data});

  CaptainLogsResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger().error('Captain Logs Response', e.toString(), StackTrace.current);
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
  String? ordersCount;
  List<Orders>? orders;

  Data({this.ordersCount, this.orders});

  Data.fromJson(dynamic json) {
    ordersCount = json['ordersCount']?.toString();
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders?.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (orders != null) {
      map['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Orders {
  DeliveryDate? deliveryDate;
  String? state;
  CreatedAt? createdAt;
  String? orderNumber;
  num? amount;
  num? deliveryCost;
  num? orderCost;
  num? orderType;

  Orders(
      {this.deliveryDate,
      this.state,
      this.createdAt,
      this.orderNumber,
      this.amount,
      this.deliveryCost,
      this.orderCost,
      this.orderType});

  Orders.fromJson(dynamic json) {
    deliveryDate = json['deliveryDate'] != null
        ? DeliveryDate.fromJson(json['deliveryDate'])
        : null;
    state = json['state'];
    createdAt = json['createdAt'] != null
        ? CreatedAt.fromJson(json['createdAt'])
        : null;
    orderNumber = json['orderNumber'];
    amount = json['amount'];
    deliveryCost = json['deliveryCost'];
    orderCost = json['orderCost'];
    orderType = json['orderType'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (deliveryDate != null) {
      map['deliveryDate'] = deliveryDate?.toJson();
    }
    map['state'] = state;
    if (createdAt != null) {
      map['createdAt'] = createdAt?.toJson();
    }
    map['orderNumber'] = orderNumber;
    map['amount'] = amount;
    map['deliveryCost'] = deliveryCost;
    map['orderCost'] = orderCost;
    map['orderType'] = orderType;
    return map;
  }
}

class CreatedAt {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  CreatedAt({this.timezone, this.offset, this.timestamp});

  CreatedAt.fromJson(dynamic json) {
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

class OrdersCount {
  int? ordersCount;

  OrdersCount({this.ordersCount});

  OrdersCount.fromJson(dynamic json) {
    ordersCount = json['ordersCount'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['ordersCount'] = ordersCount;
    return map;
  }
}

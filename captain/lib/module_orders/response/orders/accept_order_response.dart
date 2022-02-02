import 'package:mandob_moshtarayat_captain/module_orders/response/orders/geojson.dart';
import 'package:mandob_moshtarayat_captain/utils/logger/logger.dart';

class AcceptOrderResponse {
  String? statusCode;
  String? msg;
  List<AcceptedOrder>? data;

  AcceptOrderResponse({this.statusCode, this.msg, this.data});

  AcceptOrderResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = [];
        json['Data'].forEach((v) {
          data?.add(AcceptedOrder.fromJson(v));
        });
      }
    } catch (e) {
      Logger().error('AcceptOrder Response', e.toString(), StackTrace.current);
      print(StackTrace.current);
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

class AcceptedOrder {
  int? id;
  String? storeOwnerName;
  GeoJson? source;
  Destination? destination;
  DeliveryDate? deliveryDate;
  String? note;
  String? payment;
  String? recipientName;
  String? recipientPhone;
  String? state;
  List<OrderDetail>? orderDetail;
  double? deliveryCost;
  int? orderType;
  String? orderNumber;
  AcceptedOrder(
      {this.id,
      this.storeOwnerName,
      this.source,
      this.destination,
      this.deliveryDate,
      this.note,
      this.payment,
      this.recipientName,
      this.recipientPhone,
      this.state,
      this.orderDetail,
      this.deliveryCost,
      this.orderType,
      this.orderNumber});

  AcceptedOrder.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    if (json['source'] != null) {
      var src = json['source'];
      if (src is Map) {
        source = GeoJson.fromJson(src);
      }
    }
    if (json['source'] != null) {
      var src = json['source'];
      if (src is Map) {
        source = GeoJson.fromJson(src);
      }
    }
    destination = json['destination'] != null
        ? Destination.fromJson(json['destination'])
        : null;
    deliveryDate = json['deliveryDate'] != null
        ? DeliveryDate.fromJson(json['deliveryDate'])
        : null;
    note = json['note'];
    payment = json['payment'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    state = json['state'];
    orderNumber = json['orderNumber'];

    if (json['orderDetail'] != null) {
      orderDetail = [];
      json['orderDetail'].forEach((v) {
        orderDetail?.add(OrderDetail.fromJson(v));
      });
    }
    deliveryCost = json['deliveryCost']?.toDouble();
    orderType = json['orderType'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerName'] = storeOwnerName;
    if (destination != null) {
      map['destination'] = destination?.toJson();
    }
    if (deliveryDate != null) {
      map['deliveryDate'] = deliveryDate?.toJson();
    }
    map['note'] = note;
    map['payment'] = payment;
    map['recipientName'] = recipientName;
    map['recipientPhone'] = recipientPhone;
    map['state'] = state;
    if (orderDetail != null) {
      map['orderDetail'] = orderDetail?.map((v) => v.toJson()).toList();
    }
    map['deliveryCost'] = deliveryCost;
    map['orderType'] = orderType;
    return map;
  }
}

class OrderDetail {
  int? id;
  int? productID;
  int? orderID;
  String? productName;
  String? productImage;
  int? productPrice;
  int? countProduct;
  int? storeOwnerProfileID;
  int? productCategoryID;
  String? orderNumber;

  OrderDetail(
      {this.id,
      this.productID,
      this.orderID,
      this.productName,
      this.productImage,
      this.productPrice,
      this.countProduct,
      this.storeOwnerProfileID,
      this.productCategoryID,
      this.orderNumber});

  OrderDetail.fromJson(dynamic json) {
    id = json['id'];
    productID = json['productID'];
    orderID = json['orderID'];
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    countProduct = json['countProduct'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    productCategoryID = json['ProductCategoryID'];
    orderNumber = json['orderNumber'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['productID'] = productID;
    map['orderID'] = orderID;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['countProduct'] = countProduct;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['ProductCategoryID'] = productCategoryID;
    map['orderNumber'] = orderNumber;
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

class Destination {
  double? lat;
  double? long;

  Destination({this.lat, this.long});

  Destination.fromJson(dynamic json) {
    try {
      lat = json['lat'];
      long = json['long'];
    } catch (e) {
      lat = null;
      long = null;
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['lat'] = lat;
    map['long'] = long;
    return map;
  }
}

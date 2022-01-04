//import 'package:mandob_moshtarayat/module_captain/response/captain_profile_response.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_categories_response.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_products_response.dart';
import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class OrderDetailsResponse {
  String? statusCode;
  String? msg;
  Orders? data;

  OrderDetailsResponse({this.statusCode, this.msg, this.data});

  OrderDetailsResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? Orders.fromJson(json['Data']) : null;
    try {} catch (e) {
      Logger().error(
          'Order Details Response', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
  }
}

class Orders {
  List<Data>? data;

  Orders(this.data);
  Orders.fromJson(dynamic json) {
    try {
      if (json['orderDetails'] != null) {
        data = [];
        json['orderDetails'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      }
    } catch (e) {
      Logger()
          .error('My Orders Response', '${e.toString()}', StackTrace.current);
    }
  }
}

class Data {
  List<OrderDetails>? orderDetails;
  int? orderType;
  num? invoiceAmount;
  ImageUrl? invoiceImage;
  String? state;
  String? detail;
  String? note;
  CreatedAt? createdAt;
  CreatedAt? deliveryDate;
  String? roomID;

  Data(
      {this.orderDetails,
      this.invoiceAmount,
      this.orderType,
      this.createdAt,
      this.invoiceImage,
      this.state,
      this.note,
      this.detail,
      this.roomID,
      this.deliveryDate});

  Data.fromJson(dynamic json) {
    if (json['products'] != null) {
      orderDetails = [];
      json['products'].forEach((v) {
        orderDetails?.add(OrderDetails.fromJson(v));
      });
    }
    createdAt = json['createdAt'] == null ? null :  CreatedAt.fromJson(json['createdAt']);
    deliveryDate= json['deliveryDate'] == null ? null : CreatedAt.fromJson(json['deliveryDate']);
    state = json['state'];
    orderType = json['orderType'];
    invoiceAmount = json['invoiceAmount'];
    invoiceImage = ImageUrl.fromJson(json['invoiceImage']);
    detail = json['detail'];
    note = json['note'];
    roomID = json['roomID'];
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

class OrderDetails {
  int? id;
  int? productID;
  int? orderID;
  String? productName;
  ImageUrl? productImage;
  double? productPrice;
  int? countProduct;
  int? storeOwnerProfileID;
  int? productCategoryID;
  String? orderNumber;

  OrderDetails(
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

  OrderDetails.fromJson(dynamic json) {
    id = json['id'];
    productID = json['productID'];
    orderID = json['orderID'];
    productName = json['productName'];
    productImage = json['productImage'] != null
        ? ImageUrl.fromJson(json['productImage'])
        : null;
    productPrice = json['productPrice']?.toDouble();
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

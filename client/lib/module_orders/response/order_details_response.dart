import 'package:mandob_moshtarayat/module_stores/response/rating.dart';
import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class OrderDetailsResponse {
  String? statusCode;
  String? msg;
  Data? data;

  OrderDetailsResponse({this.statusCode, this.msg, this.data});

  OrderDetailsResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger().error(
          'Order Details Response', '${e.toString()}', StackTrace.current);
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
  List<OrderDetails>? orderDetails;
  StoreOwner? storeOwner;
  Order? order;

  Data({this.orderDetails, this.storeOwner, this.order});

  Data.fromJson(dynamic json) {
    if (json['orderDetails'] != null) {
      orderDetails = [];
      json['orderDetails'].forEach((v) {
        orderDetails?.add(OrderDetails.fromJson(v));
      });
    }
    storeOwner = json['storeOwner'] != null
        ? StoreOwner.fromJson(json['storeOwner'])
        : null;
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (orderDetails != null) {
      map['orderDetails'] = orderDetails?.map((v) => v.toJson()).toList();
    }
    if (storeOwner != null) {
      map['storeOwner'] = storeOwner?.toJson();
    }
    if (order != null) {
      map['order'] = order?.toJson();
    }
    return map;
  }
}

class GeoJson {
  double? long;
  double? lat;

  GeoJson({this.long, this.lat});

  GeoJson.fromJson(dynamic json) {
    long = json['long'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['long'] = long;
    map['lat'] = lat;
    return map;
  }
}

class Order {
  int? id;
  int? ownerID;
  List<dynamic>? source;
  GeoJson? destination;
  DeliveryDate? deliveryDate;
  dynamic updatedAt;
  String? note;
  String? payment;
  String? recipientName;
  String? recipientPhone;
  String? state;
  String? roomID;
  dynamic captainID;
  CreatedAt? createdAt;
  String? detail;
  double? deliveryCost;
  double? orderCost;
  int? orderType;
  num? invoiceAmount;
  String? invoiceImage;

  Order(
      {this.id,
      this.ownerID,
      this.source,
      this.destination,
      this.deliveryDate,
      this.updatedAt,
      this.note,
      this.payment,
      this.recipientName,
      this.recipientPhone,
      this.state,
      this.roomID,
      this.captainID,
      this.createdAt,
      this.detail,
      this.orderCost,
      this.deliveryCost,
      this.orderType,
      this.invoiceAmount,
      this.invoiceImage});

  Order.fromJson(dynamic json) {
    id = json['id'];
    ownerID = json['storeOwnerProfileID'];
    if (json['source'] != null) {
      source = [];
      // json['source'].forEach((v) {
      //   source?.add(dynamic.fromJson(v));
      // });
    }
    if (json['destination'] != null) {
      if (json['destination'] is String) {
      } else {
        destination = GeoJson.fromJson(json['destination']);
      }
    }
    deliveryDate = json['deliveryDate'] != null
        ? DeliveryDate.fromJson(json['deliveryDate'])
        : null;
    updatedAt = json['updatedAt'];
    note = json['note'];
    payment = json['payment'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    state = json['state'];
    roomID = json['roomID'];
    captainID = json['captainID'];
    createdAt = json['createdAt'] != null
        ? CreatedAt.fromJson(json['createdAt'])
        : null;
    detail = json['detail'];
    deliveryCost = json['deliveryCost']?.toDouble();
    orderCost = json['orderCost']?.toDouble();
    orderType = json['orderType'];
    invoiceAmount = json['invoiceAmount'];
    invoiceImage = json['invoiceImage'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['ownerID'] = ownerID;
    if (source != null) {
      map['source'] = source?.map((v) => v.toJson()).toList();
    }
    map['destination'] = destination;
    if (deliveryDate != null) {
      map['deliveryDate'] = deliveryDate?.toJson();
    }
    map['updatedAt'] = updatedAt;
    map['note'] = note;
    map['payment'] = payment;
    map['recipientName'] = recipientName;
    map['recipientPhone'] = recipientPhone;
    map['state'] = state;
    map['roomID'] = roomID;
    map['captainID'] = captainID;
    if (createdAt != null) {
      map['createdAt'] = createdAt?.toJson();
    }
    map['detail'] = detail;
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

class StoreOwner {
  int? id;
  String? storeOwnerName;
  int? storeOwnerID;
  String? image;
  dynamic branch;
  bool? free;
  List<Branches>? branches;
  dynamic city;
  dynamic phone;
  dynamic imageURL;
  dynamic baseURL;
  dynamic bank;
  Rating? rating;

  StoreOwner(
      {this.id,
      this.storeOwnerName,
      this.storeOwnerID,
      this.image,
      this.branch,
      this.free,
      this.branches,
      this.city,
      this.phone,
      this.imageURL,
      this.baseURL,
      this.bank,
      this.rating});

  StoreOwner.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    storeOwnerID = json['storeOwnerProfileID'];
    image = json['image'];
    branch = json['branch'];
    free = json['free'];
    if (json['branches'] != null) {
      branches = [];
      json['branches'].forEach((v) {
        branches?.add(Branches.fromJson(v));
      });
    }
    city = json['city'];
    phone = json['phone'];
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
    bank = json['bank'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerName'] = storeOwnerName;
    map['storeOwnerID'] = storeOwnerID;
    map['image'] = image;
    map['branch'] = branch;
    map['free'] = free;
    if (branches != null) {
      map['branches'] = branches?.map((v) => v.toJson()).toList();
    }
    map['city'] = city;
    map['phone'] = phone;
    map['imageURL'] = imageURL;
    map['baseURL'] = baseURL;
    map['bank'] = bank;
    return map;
  }
}

class Branches {
  int? id;
  String? ownerID;
  Location? location;
  dynamic? city;
  dynamic? branchName;

  Branches({this.id, this.ownerID, this.location, this.city, this.branchName});

  Branches.fromJson(dynamic json) {
    id = json['id'];
    ownerID = json['ownerID'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    city = json['city'];
    branchName = json['branchName'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['ownerID'] = ownerID;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['city'] = city;
    map['branchName'] = branchName;
    return map;
  }
}

class OrderDetails {
  int? id;
  int? productID;
  int? orderID;
  String? productName;
  String? productImage;
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
    productImage = json['productImage'];
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

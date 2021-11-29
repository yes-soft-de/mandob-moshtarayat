

import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class StoreProfileResponse {
  String? statusCode;
  String? msg;
  Data? data;

  StoreProfileResponse({
      this.statusCode, 
      this.msg, 
      this.data});

  StoreProfileResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger().error('Store Profile',e.toString(),StackTrace.current);
      statusCode = '-1';
    }
  }

  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   map['status_code'] = statusCode;
  //   map['msg'] = msg;
  //   if (data != null) {
  //     map['Data'] = data?.toJson();
  //   }
  //   return map;
  // }

}

class Data {
  int? id;
  int? storeCategoryId;
  String? storeOwnerName;
  String? storeCategoryName;
  // String? image;
  bool? free;

  String? phone;
  ImageUrl? imageURL;
  String? baseURL;
  dynamic? deliveryCost;
  bool? privateOrders;
  bool? hasProducts;
  Date? openingTime;
  Date? closingTime;
  List<Branches>? branches;

  Data({
      this.id,
    this.storeCategoryId,
      this.storeOwnerName,
    this.storeCategoryName,
      // this.image,

      this.free, 


      this.phone, 
      this.imageURL, 
      this.baseURL, 

      this.deliveryCost, 
      this.privateOrders, 
      this.hasProducts, 

      this.openingTime, 
      this.closingTime,
  this.branches,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    storeCategoryId = json['storeCategoryId'];
    storeOwnerName = json['storeOwnerName'];
    storeCategoryName = json['storeCategoryName'];
    // image = json['image'];
    free = json['free'];

    phone = json['phone'];
    imageURL = json['image'] != null ?ImageUrl.fromJson(json['image']) : null;
    baseURL = json['baseURL'];
    deliveryCost = json['deliveryCost'];
    privateOrders = json['privateOrders'];
    hasProducts = json['hasProducts'];
    // openingTime=DateTime.now();
    // openingTime=DateTime.now();
    openingTime = json['openingTime'] != null ? Date.fromJson(json['openingTime']) : null;
    closingTime = json['closingTime'] != null ? Date.fromJson(json['closingTime']) : null;
    if (json['branches'] != null) {
      branches = [];
      json['branches'].forEach((v) {
        branches?.add(Branches.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   map['id'] = id;
  //   map['storeOwnerName'] = storeOwnerName;
  //   map['image'] = image;
  //   map['branch'] = branch;
  //   map['free'] = free;
  //   map['city'] = city;
  //   map['phone'] = phone;
  //   map['imageURL'] = imageURL;
  //   map['baseURL'] = baseURL;
  //   map['deliveryCost'] = deliveryCost;
  //   map['privateOrders'] = privateOrders;
  //   map['hasProducts'] = hasProducts;
  //
  //   map['openingTime'] = openingTime;
  //   map['closingTime'] = closingTime;
  //   return map;
  // }

}

class Rating {
  dynamic? rate;

  Rating({
      this.rate});

  Rating.fromJson(dynamic json) {
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['rate'] = rate;
    return map;
  }

}

class Branches {
  int? id;
  int? storeOwnerProfileID;
  Location? location;
  dynamic? city;
  String? branchName;
  bool? free;
  String? storeOwnerName;
  bool? isActive;

  Branches({
      this.id, 
      this.storeOwnerProfileID, 
      this.location, 
      this.city, 
      this.branchName, 
      this.free, 
      this.storeOwnerName, 
      this.isActive});

  Branches.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    location = json['geoLocation'] != null ? Location.fromJson(json['geoLocation']) : null;
    city = json['city'];
    branchName = json['branchName'];
    free = json['free'];
    storeOwnerName = json['storeOwnerName'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['city'] = city;
    map['branchName'] = branchName;
    map['free'] = free;
    map['storeOwnerName'] = storeOwnerName;
    map['isActive'] = isActive;
    return map;
  }

}

class Location {
  num? lat;
  num? lon;

  Location({
      this.lat, 
      this.lon});

  Location.fromJson(dynamic json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['lat'] = lat;
    map['lon'] = lon;
    return map;
  }

}
class Date {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  Date({
    this.timezone,
    this.offset,
    this.timestamp});

  Date.fromJson(dynamic json) {
    timezone = json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null;
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

  Timezone({
    this.name,
    this.transitions,
    this.location});

  Timezone.fromJson(dynamic json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = [];
      json['transitions'].forEach((v) {
        transitions?.add(Transitions.fromJson(v));
      });
    }
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
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


class Transitions {
  int? ts;
  String? time;
  int? offset;
  bool? isdst;
  String? abbr;

  Transitions({
    this.ts,
    this.time,
    this.offset,
    this.isdst,
    this.abbr});

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

class ImageUrl {
  String? image;
  ImageUrl({
    this.image,
  });

  ImageUrl.fromJson(dynamic json) {
    image = json['image'];
  }
}
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/response/favorite_response/image.dart';
import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class StoreProfileResponse {
  StoreProfileResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  StoreProfileResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    } catch (e) {
      Logger()
          .error('Store Profile Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
  String? statusCode;
  String? msg;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.storeOwnerName,
    this.image,
    this.branch,
    this.free,
    this.branches,
    this.city,
    this.phone,
    this.imageURL,
    this.baseURL,
    this.deliveryCost,
    this.privateOrders,
    this.hasProducts,
    this.rating,
    this.openingTime,
    this.closingTime,
    this.storeCategoryId,
    this.storeCategoryName,
    this.status,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
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
    deliveryCost = json['deliveryCost'];
    privateOrders = json['privateOrders'];
    hasProducts = json['hasProducts'];
    rating = json['rating'];
    openingTime = json['openingTime'] != null
        ? OpeningTime.fromJson(json['openingTime'])
        : null;
    closingTime = json['closingTime'] != null
        ? ClosingTime.fromJson(json['closingTime'])
        : null;
    storeCategoryId = json['storeCategoryId'];
    storeCategoryName = json['storeCategoryName'];
    status = json['status'];
  }
  int? id;
  String? storeOwnerName;
  Image? image;
  dynamic branch;
  bool? free;
  List<Branches>? branches;
  dynamic city;
  dynamic phone;
  String? imageURL;
  String? baseURL;
  dynamic deliveryCost;
  bool? privateOrders;
  bool? hasProducts;
  String? rating;
  OpeningTime? openingTime;
  ClosingTime? closingTime;
  int? storeCategoryId;
  String? storeCategoryName;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerName'] = storeOwnerName;
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
    map['deliveryCost'] = deliveryCost;
    map['privateOrders'] = privateOrders;
    map['hasProducts'] = hasProducts;
    if (openingTime != null) {
      map['openingTime'] = openingTime?.toJson();
    }
    if (closingTime != null) {
      map['closingTime'] = closingTime?.toJson();
    }
    map['storeCategoryId'] = storeCategoryId;
    map['storeCategoryName'] = storeCategoryName;
    map['status'] = status;
    return map;
  }
}

class ClosingTime {
  ClosingTime({
    this.timezone,
    this.offset,
    this.timestamp,
  });

  ClosingTime.fromJson(dynamic json) {
    timezone =
        json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }
  Timezone? timezone;
  int? offset;
  int? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (timezone != null) {
      map['timezone'] = timezone?.toJson();
    }
    map['offset'] = offset;
    map['timestamp'] = timestamp;
    return map;
  }
}

class Timezone {
  Timezone({
    this.name,
    this.transitions,
    this.location,
  });

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
  String? name;
  List<Transitions>? transitions;
  Location? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
  Location({
    this.countryCode,
    this.latitude,
    this.longitude,
    this.comments,
  });

  Location.fromJson(dynamic json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }
  String? countryCode;
  int? latitude;
  int? longitude;
  String? comments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_code'] = countryCode;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['comments'] = comments;
    return map;
  }
}

class Transitions {
  Transitions({
    this.ts,
    this.time,
    this.offset,
    this.isdst,
    this.abbr,
  });

  Transitions.fromJson(dynamic json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }
  int? ts;
  String? time;
  int? offset;
  bool? isdst;
  String? abbr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ts'] = ts;
    map['time'] = time;
    map['offset'] = offset;
    map['isdst'] = isdst;
    map['abbr'] = abbr;
    return map;
  }
}

class OpeningTime {
  OpeningTime({
    this.timezone,
    this.offset,
    this.timestamp,
  });

  OpeningTime.fromJson(dynamic json) {
    timezone =
        json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }
  Timezone? timezone;
  int? offset;
  int? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (timezone != null) {
      map['timezone'] = timezone?.toJson();
    }
    map['offset'] = offset;
    map['timestamp'] = timestamp;
    return map;
  }
}

class Rating {
  Rating({
    this.rate,
  });

  Rating.fromJson(dynamic json) {
    rate = json['rate'];
  }
  dynamic rate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = rate;
    return map;
  }
}

class Branches {
  Branches({
    this.id,
    this.storeOwnerProfileID,
    this.location,
    this.city,
    this.branchName,
    this.free,
    this.storeOwnerName,
    this.isActive,
  });

  Branches.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    if (json['location'] != null) {
      location = [];
      json['location'].forEach((v) {
        // location?.add(dynamic.fromJson(v));
      });
    }
    city = json['city'];
    branchName = json['branchName'];
    free = json['free'];
    storeOwnerName = json['storeOwnerName'];
    isActive = json['isActive'];
  }
  int? id;
  int? storeOwnerProfileID;
  List<dynamic>? location;
  dynamic city;
  dynamic branchName;
  bool? free;
  String? storeOwnerName;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    if (location != null) {
      map['location'] = location?.map((v) => v.toJson()).toList();
    }
    map['city'] = city;
    map['branchName'] = branchName;
    map['free'] = free;
    map['storeOwnerName'] = storeOwnerName;
    map['isActive'] = isActive;
    return map;
  }
}

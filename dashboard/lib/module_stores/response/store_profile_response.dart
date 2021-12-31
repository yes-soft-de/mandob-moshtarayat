import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

class StoreProfileResponse {
  String? statusCode;
  String? msg;
  Data? data;

  StoreProfileResponse({this.statusCode, this.msg, this.data});

  StoreProfileResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    try {} catch (e) {
      Logger().error('Store Profile', e.toString(), StackTrace.current);
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
  int? id;
  String? storeOwnerName;
  ImageUrl? image;
  dynamic? branch;
  bool? free;
  List<Branches>? branches;
  dynamic? city;
  String? phone;
  String? imageURL;
  String? baseURL;
  dynamic? bank;
  dynamic? deliveryCost;
  bool? privateOrders;
  bool? hasProducts;
//  Rating? rating;
  Date? openingTime;
  Date? closingTime;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
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
    this.bank,
    this.deliveryCost,
    this.privateOrders,
    this.hasProducts,
//      this.rating,
    this.openingTime,
    this.closingTime,
    this.bankAccountNumber,
    this.bankName,
    this.stcPay,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    image = ImageUrl.fromJson(json['image']);
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
    deliveryCost = json['deliveryCost'];
    privateOrders = json['privateOrders'];
    hasProducts = json['hasProducts'];
//    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    openingTime =
        json['openingTime'] != null ? Date.fromJson(json['openingTime']) : null;
    closingTime =
        json['closingTime'] != null ? Date.fromJson(json['closingTime']) : null;
    bankName = json['bankName'];
    bankAccountNumber = json['bankAccountNumber'];
    stcPay = json['stcPay'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
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
    map['bank'] = bank;
    map['deliveryCost'] = deliveryCost;
    map['privateOrders'] = privateOrders;
    map['hasProducts'] = hasProducts;
//    if (rating != null) {
//      map['rating'] = rating?.toJson();
//    }
    map['openingTime'] = openingTime;
    map['closingTime'] = closingTime;
    return map;
  }
}

class Rating {
  dynamic? rate;

  Rating({this.rate});

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

  Branches(
      {this.id,
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
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
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
  double? lat;
  double? lon;

  Location({this.lat, this.lon});

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

class ImageUrl {
  String? image;
  String? imageURL;
  String? baseURL;
  ImageUrl({this.image, this.imageURL, this.baseURL});

  ImageUrl.fromJson(dynamic json) {
    image = json['image'];
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
  }
}

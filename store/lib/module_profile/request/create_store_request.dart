
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';

class CreateStoreRequest {
  String? storeOwnerName;
  String? image;
  int? storeCategoryId;
  int? privateOrders;
  int? hasProducts;
  String? phone;
  num? deliveryCost;
  GeoJson? location;
  String? closingTime;
  String? openingTime;
  String? status;
  CreateStoreRequest({
      this.storeOwnerName, 
      this.image, 
      this.storeCategoryId, 
      this.privateOrders, 
      this.hasProducts,
      this.deliveryCost,
      this.phone,
      this.location,
      this.closingTime,
      this.openingTime,
      this.status
  });

  CreateStoreRequest.fromJson(dynamic json) {
    storeOwnerName = json['storeOwnerName'];
    image = json['image'];
    storeCategoryId = json['storeCategoryId'];
    privateOrders = json['privateOrders'];
    hasProducts = json['hasProducts'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['storeOwnerName'] = storeOwnerName;
    map['phone'] = phone;
//    map['deliveryCost'] = deliveryCost;
    map['image'] = image;
    map['storeCategoryId'] = storeCategoryId;
    map['privateOrders'] = privateOrders;
    map['hasProducts'] = hasProducts;
    map['closingTime'] = closingTime;
    map['openingTime'] = openingTime;
    map['status'] = status;
    map['location'] = location?.toJson();
    return map;
  }

}
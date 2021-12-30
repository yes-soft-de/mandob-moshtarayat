import 'package:mandob_moshtarayat_dashboad/module_stores/response/stores_response.dart';

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
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  CreateStoreRequest(
      {this.storeOwnerName,
      this.image,
      this.storeCategoryId,
      this.privateOrders,
      this.hasProducts,
      this.deliveryCost,
      this.phone,
      this.location,
      this.closingTime,
      this.openingTime,
      this.status,
      this.stcPay,
      this.bankAccountNumber,
      this.bankName});

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
    map['stcPay'] = stcPay;
    map['bankAccountNumber'] = bankAccountNumber;
    map['bankName'] = bankName;
    return map;
  }
}

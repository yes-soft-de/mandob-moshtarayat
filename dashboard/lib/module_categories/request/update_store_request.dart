class UpdateStoreRequest {
  String? id;
  String? status;
  int? isBest;
  String? storeOwnerName;
  String? image;
  int? storeCategoryId;
  int? privateOrders;
  int? hasProducts;
  String? closingTime;
  String? openingTime;
  UpdateStoreRequest(
      {this.id,
      this.status,
      this.isBest,
      this.storeOwnerName,
      this.image,
      this.storeCategoryId,
      this.privateOrders,
      this.hasProducts,
      this.closingTime,
      this.openingTime,
      });

  UpdateStoreRequest.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    isBest = json['is_best'];
    storeOwnerName = json['storeOwnerName'];
    image = json['image'];
    storeCategoryId = json['storeCategoryId'];
    privateOrders = json['privateOrders'];
    hasProducts = json['hasProducts'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['is_best'] = isBest;
    map['storeOwnerName'] = storeOwnerName;
    map['image'] = image;
    map['storeCategoryId'] = storeCategoryId;
    map['privateOrders'] = privateOrders;
    map['hasProducts'] = hasProducts;
    map['closingTime'] = closingTime;
    map['openingTime'] = openingTime;
    return map;
  }
}

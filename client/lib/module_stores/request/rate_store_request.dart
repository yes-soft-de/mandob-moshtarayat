class RateStoreRequest {
  int? itemID;
  String? itemType;
  num? rating;

  RateStoreRequest({
      this.itemID, 
      this.itemType, 
      this.rating,
  });

  RateStoreRequest.fromJson(dynamic json) {
    itemID = json['itemID'];
    itemType = json['itemType'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['itemID'] = itemID;
    map['itemType'] = itemType;
    map['rating'] = rating;
    return map;
  }

}

class RateCaptainRequest {
  String? orderNumber;
  String? itemType;
  num? rating;

  RateCaptainRequest({
    this.orderNumber,
    this.itemType,
    this.rating,
  });

  RateCaptainRequest.fromJson(dynamic json) {
    orderNumber = json['orderNumber'];
    itemType = json['itemType'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['orderNumber'] = orderNumber;
    map['itemType'] = itemType;
    map['rating'] = rating;
    return map;
  }

}
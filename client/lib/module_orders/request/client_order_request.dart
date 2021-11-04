class ClientOrderRequest {
  int? orderNumber;
  GeoJson? destination;
  String? note;
  String? payment;
  int? ownerID;
  List<Products>? products;
  String? deliveryDate;
  double? orderCost;
  num? deliveryCost;
  String? detail;
  String? recipientName;
  String? recipientPhone;
  int? orderType;
  ClientOrderRequest({
      this.destination, 
      this.note, 
      this.payment, 
      this.ownerID, 
      this.products, 
      this.deliveryDate, 
      this.orderCost, 
      this.deliveryCost,
      this.orderNumber,
      this.detail,
      this.recipientName,
      this.recipientPhone,
      this.orderType
  });

  ClientOrderRequest.fromJson(dynamic json) {
    destination = json['destination'];
    note = json['note'];
    payment = json['payment'];
    ownerID = json['storeOwnerProfileID'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    deliveryDate = json['deliveryDate'];
    orderCost = json['orderCost'];
    deliveryCost = json['deliveryCost'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (this.orderNumber != null){
      map['orderNumber'] = orderNumber;
    }
    map['destination'] = destination?.toJson();
    map['note'] = note;
    map['payment'] = payment;
    map['storeOwnerProfileID'] = ownerID;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['deliveryDate'] = deliveryDate;
    map['orderCost'] = orderCost;
    map['deliveryCost'] = deliveryCost;
    if (detail != null) {
      map['detail'] = detail;
    }
    if (recipientName != null) {
    map['recipientName'] = recipientName;
    }
    if (recipientPhone != null){
      map['recipientPhone'] = recipientPhone;
    }
    return map;
  }

}
class GeoJson {
  double? long;
  double? lat;

  GeoJson({this.long, this.lat});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['long'] = long;
    map['lat'] = lat;
    return map;
  }
}
class Products {
  int? productID;
  int? countProduct;
  double? price;
  String? productName;
  String? productsImage;
  Products({
      this.productID, 
      this.countProduct,
      this.price,
      this.productName,
      this.productsImage
  });

  Products.fromJson(dynamic json) {
    productID = json['productID'];
    countProduct = json['countProduct'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productID'] = productID;
    map['countProduct'] = countProduct;
    return map;
  }

}
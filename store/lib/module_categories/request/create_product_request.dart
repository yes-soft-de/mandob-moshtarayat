class CreateProductRequest {
  String? productName;
  String? productImage;
  String? description;
  num? productPrice;
  num? productQuantity;
  num? discount;
  int? storeProductCategoryID;

  CreateProductRequest({
      this.productName, 
      this.productImage, 
      this.productPrice,
    this.productQuantity,
      this.discount, this.description,
      this.storeProductCategoryID});

  CreateProductRequest.fromJson(dynamic json) {
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    productQuantity  = json['productQuantity'];
    discount = json['discount'];
    description = json['description'];
    storeProductCategoryID = json['storeProductCategoryID'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['productQuantity'] = productQuantity;
    map['discount'] = discount;
    map['description'] = description;
    map['storeProductCategoryID'] = storeProductCategoryID;
    return map;
  }

}
class CreateProductRequest {
  String? productName;
  String? productImage;
  String? description;
  num? productPrice;
  num? discount;
  int? storeProductCategoryID;

  CreateProductRequest({
      this.productName, 
      this.productImage, 
      this.productPrice, 
      this.discount, this.description,
      this.storeProductCategoryID});

  CreateProductRequest.fromJson(dynamic json) {
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    discount = json['discount'];
    description = json['description'];
    storeProductCategoryID = json['storeProductCategoryID'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['discount'] = discount;
    map['description'] = description;
    map['storeProductCategoryID'] = storeProductCategoryID;
    return map;
  }

}
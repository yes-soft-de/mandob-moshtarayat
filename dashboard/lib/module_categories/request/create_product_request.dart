class CreateProductRequest {
  String? productName;
  String? productImage;
  num? productPrice;
  int? storeOwnerProfileID;
  int? storeProductCategoryID;

  CreateProductRequest({
      this.productName, 
      this.productImage, 
      this.productPrice, 
      this.storeOwnerProfileID, 
      this.storeProductCategoryID});

  CreateProductRequest.fromJson(dynamic json) {
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    storeProductCategoryID = json['storeProductCategoryID'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['storeProductCategoryID'] = storeProductCategoryID;
    return map;
  }

}
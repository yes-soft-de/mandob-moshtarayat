class UpdateProductRequest {
  int? id;
  String? productName;
  String? productImage;
  double? productPrice;
  int? storeOwnerProfileID;
  int? storeProductCategoryID;

  UpdateProductRequest({
      this.id, 
      this.productName, 
      this.productImage, 
      this.productPrice, 
      this.storeOwnerProfileID, 
      this.storeProductCategoryID});

  UpdateProductRequest.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    storeProductCategoryID = json['storeProductCategoryID'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['storeProductCategoryID'] = storeProductCategoryID;
    return map;
  }

}
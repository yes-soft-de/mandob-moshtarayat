class UpdateProductCategoryRequest {
  String? id;
  String? productCategoryName;
  int? storeOwnerProfileId;

  UpdateProductCategoryRequest({
      this.id, 
      this.productCategoryName, 
      this.storeOwnerProfileId});

  UpdateProductCategoryRequest.fromJson(dynamic json) {
    id = json['id'];
    productCategoryName = json['productCategoryName'];
    storeOwnerProfileId = json['storeOwnerProfileId'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['productCategoryName'] = productCategoryName;
    map['storeOwnerProfileId'] = storeOwnerProfileId;
    return map;
  }

}
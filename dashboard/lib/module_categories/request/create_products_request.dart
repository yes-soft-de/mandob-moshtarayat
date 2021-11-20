class CreateProductsCategoriesRequest {
  String? productCategoryName;
  int? storeOwnerProfileId;
  String? productCategoryImage;
  CreateProductsCategoriesRequest({
      this.productCategoryName,this.storeOwnerProfileId});

  CreateProductsCategoriesRequest.fromJson(dynamic json) {
    productCategoryName = json['productCategoryName'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productCategoryName'] = productCategoryName;
    map['storeOwnerProfileId'] = storeOwnerProfileId.toString();
    map['productCategoryImage'] = '';
    return map;
  }

}
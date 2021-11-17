class CategoryLevelTowRequest {
  CategoryLevelTowRequest({
    this.productCategoryName,
    this.productCategoryImage,
    this.storeProductCategoryID,
  });

  CategoryLevelTowRequest.fromJson(dynamic json) {
    productCategoryName = json['productCategoryName'];
    productCategoryImage = json['productCategoryImage'];
    storeProductCategoryID = json['storeProductCategoryID'];
  }

  String? productCategoryName;
  String? productCategoryImage;
  int? storeProductCategoryID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productCategoryName'] = productCategoryName;
    map['productCategoryImage'] = productCategoryImage;
    if (storeProductCategoryID != null) {
      map['storeProductCategoryID'] = storeProductCategoryID;
    }
    return map;
  }
}

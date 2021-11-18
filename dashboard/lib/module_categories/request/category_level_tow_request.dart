class CategoryLevelTowRequest {
  CategoryLevelTowRequest({
    this.id,
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
  int? id;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productCategoryName'] = productCategoryName;
    map['productCategoryImage'] = productCategoryImage;
    if (storeProductCategoryID != null) {
      map['storeProductCategoryID'] = storeProductCategoryID;
    }
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}

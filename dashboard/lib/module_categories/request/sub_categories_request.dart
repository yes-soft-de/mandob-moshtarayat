class SubCategoriesRequest {
  SubCategoriesRequest({
      this.id, 
      this.productCategoryName, 
      this.productCategoryImage, 
      this.storeCategoryID,});

  SubCategoriesRequest.fromJson(dynamic json) {
    id = json['id'];
    productCategoryName = json['productCategoryName'];
    productCategoryImage = json['productCategoryImage'];
    storeCategoryID = json['storeCategoryID'];
  }
  int? id;
  String? productCategoryName;
  String? productCategoryImage;
  int? storeCategoryID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null){
      map['id'] = id;
    }
    map['productCategoryName'] = productCategoryName;
    map['productCategoryImage'] = productCategoryImage;
    map['storeCategoryID'] = storeCategoryID;
    return map;
  }

}
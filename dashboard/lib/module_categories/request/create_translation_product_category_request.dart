class CreateNewTransProductCategoryRequest {
  int? storeProductCategoryID;
  String? storeProductCategoryName;
  String? language;

  CreateNewTransProductCategoryRequest(
      {this.storeProductCategoryName,
      this.storeProductCategoryID,
      this.language});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['language'] = language;
    map['productCategoryName'] = storeProductCategoryName;
    map['storeProductCategoryID'] = storeProductCategoryID;
    return map;
  }
}

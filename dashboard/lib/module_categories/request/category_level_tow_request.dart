class DataStoreCategoryTwo {
  DataStoreCategoryTwo({
    this.id,
    this.productCategoryName,
    this.productCategoryImage,
    this.storeProductCategoryID,
  });

  DataStoreCategoryTwo.fromJson(dynamic json) {
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
      //   map['storeProductCategoryID'] = storeProductCategoryID;
    }
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}

class TranslateSubTwoCategory {
  String? productCategoryName;
  String? lang;
  int? productCategoryID;

  TranslateSubTwoCategory(
      {this.productCategoryName, this.lang, this.productCategoryID});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productCategoryName'] = productCategoryName;
    //  map['storeProductCategoryID'] = productCategoryID;
    map['language'] = lang;
    return map;
  }
}

class CategoryLevelTowRequest {
  DataStoreCategoryTwo? dataStoreCategory;
  List<TranslateSubTwoCategory>? translate;

  CategoryLevelTowRequest({this.dataStoreCategory, this.translate});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['data'] = dataStoreCategory?.toJson();
    if (translate != null) {
      map['translate'] = translate?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

//class SubCategoriesRequest {
//  SubCategoriesRequest({
//      this.id,
//      this.productCategoryName,
//      this.productCategoryImage,
//      this.storeCategoryID,
//  });
//
//  SubCategoriesRequest.fromJson(dynamic json) {
//    id = json['id'];
//    productCategoryName = json['productCategoryName'];
//    productCategoryImage = json['productCategoryImage'];
//    storeCategoryID = json['storeCategoryID'];
//  }
//  int? id;
//  String? productCategoryName;
//  String? productCategoryImage;
//  int? storeCategoryID;
//
//  Map<String, dynamic> toJson() {
//    final map = <String, dynamic>{};
//    if (id != null){
//      map['id'] = id;
//    }
//    map['productCategoryName'] = productCategoryName;
//    map['productCategoryImage'] = productCategoryImage;
//    map['storeCategoryID'] = storeCategoryID;
//    return map;
//  }
//
//}

class SubCategoriesRequest {
  DataStoreCategory? dataStoreCategory;
  List<TranslateSubCategory>? translate;

  SubCategoriesRequest({this.dataStoreCategory, this.translate});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['data'] = dataStoreCategory?.toJson();
    if (translate != null) {
      map['translate'] = translate?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TranslateSubCategory {
  String? productCategoryName;
  String? lang;
  int? productCategoryID;

  TranslateSubCategory(
      {this.productCategoryName, this.lang, this.productCategoryID});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productCategoryName'] = productCategoryName;
    map['storeProductCategoryID'] = productCategoryID;
    map['language'] = lang;
    return map;
  }
}

class DataStoreCategory {
  int? id;
  String? productCategoryName;
  String? productCategoryImage;
  int? storeCategoryID;

  DataStoreCategory({
    this.id,
    this.productCategoryName,
    this.productCategoryImage,
    this.storeCategoryID,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['productCategoryName'] = productCategoryName;
    map['productCategoryImage'] = productCategoryImage;
    //   map['storeCategoryID'] = storeCategoryID;
    return map;
  }
}

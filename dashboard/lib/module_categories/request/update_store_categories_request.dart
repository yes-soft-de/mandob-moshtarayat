//class UpdateStoreCategoriesRequest {
//  int? id;
//  String? storeCategoryName;
//  String? description;
//  String? image;
//  String? baseImage;
//
//  UpdateStoreCategoriesRequest({
//      this.id,
//      this.storeCategoryName,
//      this.description,
//      this.image,
//      this.baseImage
//  });
//
//  UpdateStoreCategoriesRequest.fromJson(dynamic json) {
//    id = json['id'];
//    storeCategoryName = json['storeCategoryName'];
//    description = json['description'];
//    image = json['image'];
//  }
//
//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map['id'] = id;
//    map['storeCategoryName'] = storeCategoryName;
//    map['description'] = description;
//    map['image'] = image;
//    return map;
//  }
//
//}

class UpdateStoreCategoriesRequest {
  DataUpdateStoreCategory? dataStoreCategory;
  List<TranslateUpdateStoreCategory>? translate;

  UpdateStoreCategoriesRequest({this.dataStoreCategory, this.translate});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['data'] = dataStoreCategory?.toJson();
    if (translate != null) {
      map['translate'] = translate?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TranslateUpdateStoreCategory {
  int? storeCategoryID;
  String? storeCategoryName;
  String? lang;

  TranslateUpdateStoreCategory(
      {this.storeCategoryID, this.storeCategoryName, this.lang});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['storeCategoryName'] = storeCategoryName;
    map['storeCategoryID'] = storeCategoryID;
    map['language'] = lang;
    return map;
  }
}

class DataUpdateStoreCategory {
  int? id;
  String? storeCategoryName;
  String? description;
  String? lang;
  String? image;
  String? baseImage;

  DataUpdateStoreCategory(
      {this.id,
      this.storeCategoryName,
      this.description,
      this.lang,
      this.baseImage,
      this.image});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeCategoryName'] = storeCategoryName;
    map['description'] = description;
    map['image'] = image;
    map['language'] = lang;
    return map;
  }
}

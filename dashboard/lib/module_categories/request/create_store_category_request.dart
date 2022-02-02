class CreateStoreCategoryRequest {
  DataStoreCategory? dataStoreCategory;
  List<TranslateStoreCategory>? translate;

  CreateStoreCategoryRequest({this.dataStoreCategory, this.translate});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['data'] = dataStoreCategory?.toJson();
    if (translate != null) {
      map['translate'] = translate?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TranslateStoreCategory {
  String? storeCategoryName;
  String? lang;

  TranslateStoreCategory({this.storeCategoryName, this.lang});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['storeCategoryName'] = storeCategoryName;
    map['language'] = lang;
    return map;
  }
}

class DataStoreCategory {
  String? storeCategoryName;
  String? description;
  String? lang;
  String? image;

  DataStoreCategory(
      {this.storeCategoryName, this.description, this.lang, this.image});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['storeCategoryName'] = storeCategoryName;
    map['description'] = description;
    map['image'] = image;
    map['language'] = lang;
    return map;
  }
}

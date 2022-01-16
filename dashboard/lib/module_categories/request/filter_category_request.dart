class FilterLanguageCategoryRequest {
  String? language;

  FilterLanguageCategoryRequest({this.language});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['language'] = language;
    return map;
  }
}

class FilterLanguageAndCategoryRequest {
  String? language;
  int? storeCategoryID;

  FilterLanguageAndCategoryRequest({this.language, this.storeCategoryID});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['language'] = language;
    if (storeCategoryID != null) {
      map['storeCategoryID'] = storeCategoryID;
    }
    return map;
  }
}

class FilterLanguageAndProductCategoryRequest {
  String? language;
  int? storeCategoryID;

  FilterLanguageAndProductCategoryRequest(
      {this.language, this.storeCategoryID});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['language'] = language;
    if (storeCategoryID != null) {
      map['storeProductCategoryID'] = storeCategoryID;
    }
    return map;
  }
}

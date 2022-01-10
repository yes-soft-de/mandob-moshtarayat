class CreateNewTransStoreCategoryRequest {
  int? storeCategoryID;
  String? storeCategoryName;
  String? language;

  CreateNewTransStoreCategoryRequest({this.storeCategoryName , this.storeCategoryID , this.language});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['language'] = language;
    map['storeCategoryName'] = storeCategoryName;
    map['storeCategoryID'] = storeCategoryID;
    return map;
  }
}

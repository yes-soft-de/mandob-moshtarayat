class MainLinkRequest {
  List<String>? mainCategoriesIDs;
  int? subCategoryLevelOneId;

  MainLinkRequest({this.mainCategoriesIDs, this.subCategoryLevelOneId});

  factory MainLinkRequest.fromJson(Map<String, dynamic> json) {
    return MainLinkRequest(
      mainCategoriesIDs: json['mainCategoriesIDs'] as List<String>?,
      subCategoryLevelOneId: json['subCategoryLevelOneID'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'mainCategoriesIDs': mainCategoriesIDs,
        'subCategoryLevelOneID': subCategoryLevelOneId,
      };
}

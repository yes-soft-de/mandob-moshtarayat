class SubLinkRequest {
  int? subCategoryLevelOneId;
  int? subCategoryLevelTwoId;

  SubLinkRequest({this.subCategoryLevelOneId, this.subCategoryLevelTwoId});

  factory SubLinkRequest.fromJson(Map<String, dynamic> json) {
    return SubLinkRequest(
      subCategoryLevelOneId: json['subCategoryLevelOneID'] as int?,
      subCategoryLevelTwoId: json['subCategoryLevelTwoID'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'subCategoryLevelOneID': subCategoryLevelOneId,
        'subCategoryLevelTwoID': subCategoryLevelTwoId,
      };
}

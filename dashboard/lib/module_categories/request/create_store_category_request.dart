class CreateStoreCategoryRequest {
  String? storeCategoryName;
  String? description;
  String? image;

  CreateStoreCategoryRequest({
      this.storeCategoryName, 
      this.description, 
      this.image});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['storeCategoryName'] = storeCategoryName;
    map['description'] = description;
    map['image'] = image;
    return map;
  }

}
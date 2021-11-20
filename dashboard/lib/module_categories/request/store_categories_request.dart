class UpdateStoreCategoriesRequest {
  int? id;
  String? storeCategoryName;
  String? description;
  String? image;
  String? baseImage;

  UpdateStoreCategoriesRequest({
      this.id, 
      this.storeCategoryName, 
      this.description, 
      this.image,
      this.baseImage
  });

  UpdateStoreCategoriesRequest.fromJson(dynamic json) {
    id = json['id'];
    storeCategoryName = json['storeCategoryName'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['storeCategoryName'] = storeCategoryName;
    map['description'] = description;
    map['image'] = image;
    return map;
  }

}
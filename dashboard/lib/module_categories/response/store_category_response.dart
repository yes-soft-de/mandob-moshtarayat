class CategoryResponse {
  CategoryResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  CategoryResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = Data.fromJson(json['Data']);
    }
  }
  String? statusCode;
  String? msg;
  Data? data;

}

class Data {
  Data({
    this.id,
    this.categoryName,
    this.categoryImage,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    categoryName = json['storeCategoryName'];
    categoryImage = json['image'] != null
        ? ProductCategoryImage.fromJson(json['image'])
        : null;
    if (json['translate'] != null) {
      translates = [];
      json['translate'].forEach((v) {
        translates?.add(Translate.fromJson(v));
      });
    }
  }
  int? id;
  String? categoryName;
  ProductCategoryImage? categoryImage;
  List<Translate>? translates;

}

class ProductCategoryImage {
  ProductCategoryImage({
    this.imageURL,
    this.image,
    this.baseURL,
  });

  ProductCategoryImage.fromJson(dynamic json) {
    imageURL = json['imageURL'];
    image = json['image'];
    baseURL = json['baseURL'];
  }
  String? imageURL;
  String? image;
  String? baseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageURL'] = imageURL;
    map['image'] = image;
    map['baseURL'] = baseURL;
    return map;
  }
}

class Translate{
  int? id;
  String? language;
  String? storeCategoryName;

  Translate({ this.id, this.language, this.storeCategoryName });

  Translate.fromJson(dynamic json) {
    id = json['id'];
    language = json['language'];
    storeCategoryName = json['storeCategoryName'];
  }
}
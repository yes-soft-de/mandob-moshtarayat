class SubCategoriesResponse {
  SubCategoriesResponse({
      this.statusCode, 
      this.msg, 
      this.data,});

  SubCategoriesResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  String? statusCode;
  String? msg;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['msg'] = msg;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.productCategoryName, 
      this.productCategoryImage,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    productCategoryName = json['productCategoryName'];
    productCategoryImage = json['productCategoryImage'] != null ? ProductCategoryImage.fromJson(json['productCategoryImage']) : null;
  }
  int? id;
  String? productCategoryName;
  ProductCategoryImage? productCategoryImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productCategoryName'] = productCategoryName;
    if (productCategoryImage != null) {
      map['productCategoryImage'] = productCategoryImage?.toJson();
    }
    return map;
  }

}

class ProductCategoryImage {
  ProductCategoryImage({
      this.imageURL, 
      this.image, 
      this.baseURL,});

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
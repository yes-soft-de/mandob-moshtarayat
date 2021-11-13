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
      this.productCategoryName, 
      this.productCategoryImage, 
      this.productCategoriesLevel2,});

  Data.fromJson(dynamic json) {
    productCategoryName = json['productCategoryName'];
    productCategoryImage = json['productCategoryImage'] != null ? ProductCategoryImage.fromJson(json['productCategoryImage']) : null;
    if (json['productCategoriesLevel2'] != null) {
      productCategoriesLevel2 = [];
      json['productCategoriesLevel2'].forEach((v) {
        productCategoriesLevel2?.add(ProductCategoriesLevel2.fromJson(v));
      });
    }
  }
  String? productCategoryName;
  ProductCategoryImage? productCategoryImage;
  List<ProductCategoriesLevel2>? productCategoriesLevel2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productCategoryName'] = productCategoryName;
    if (productCategoryImage != null) {
      map['productCategoryImage'] = productCategoryImage?.toJson();
    }
    if (productCategoriesLevel2 != null) {
      map['productCategoriesLevel2'] = productCategoriesLevel2?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ProductCategoriesLevel2 {
  ProductCategoriesLevel2({
      this.id, 
      this.productCategoryName, 
      this.isLevel2, 
      this.productCategoryImage,});

  ProductCategoriesLevel2.fromJson(dynamic json) {
    id = json['id'];
    productCategoryName = json['productCategoryName'];
    isLevel2 = json['isLevel2'];
    productCategoryImage =json['productCategoryImage'] != null ? ProductCategoryImage.fromJson(json['productCategoryImage']) : null;
  }
  int? id;
  String? productCategoryName;
  bool? isLevel2;
  ProductCategoryImage? productCategoryImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productCategoryName'] = productCategoryName;
    map['isLevel2'] = isLevel2;
    map['productCategoryImage'] = productCategoryImage;
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
class ProductsByCategoriesResponse {
  ProductsByCategoriesResponse({
      this.statusCode, 
      this.msg, 
      this.data,});

  ProductsByCategoriesResponse.fromJson(dynamic json) {
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
      this.productName, 
      this.productPrice, 
      this.storeOwnerProfileID, 
      this.storeProductCategoryID, 
      this.image, 
      this.imageURL, 
      this.baseURL,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    storeProductCategoryID = json['storeProductCategoryID'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
  }
  int? id;
  String? productName;
  int? productPrice;
  int? storeOwnerProfileID;
  int? storeProductCategoryID;
  Image? image;
  dynamic imageURL;
  dynamic baseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productPrice'] = productPrice;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['storeProductCategoryID'] = storeProductCategoryID;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['imageURL'] = imageURL;
    map['baseURL'] = baseURL;
    return map;
  }

}

class Image {
  Image({
      this.imageURL, 
      this.image, 
      this.baseURL,});

  Image.fromJson(dynamic json) {
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
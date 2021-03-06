class DataStoreUpdateProduct {
  int? id;
  String? productName;
  String? productImage;
  String? productStatus;
  num? discount;
  num? productQuantity;
  double? productPrice;
  int? storeOwnerProfileID;
  int? storeProductCategoryID;
  int? storeMainCategoryID;
  bool  isLevelOne = false;
  bool  isLevelTwo=false;
  int? categoryName;
  DataStoreUpdateProduct(
      {this.id,
      this.productName,
      this.productImage,
      this.productPrice,
      this.discount,
      this.storeOwnerProfileID,
      this.storeProductCategoryID,
      this.productQuantity,
        this.productStatus,
      this.storeMainCategoryID,
      required this.isLevelTwo ,
     required  this.isLevelOne ,
      this.categoryName
      });

  DataStoreUpdateProduct.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    discount = json['discount'];
    productQuantity = json['productQuantity'];
    storeOwnerProfileID = json['storeOwnerProfileID'];
    storeProductCategoryID = json['storeProductCategoryID'];
    isLevelOne = json['isLevel1']??false;
    isLevelTwo = json['isLevel2']??false;
    productStatus = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['discount'] = discount;
    map['storeOwnerProfileID'] = storeOwnerProfileID;
    map['storeProductCategoryID'] = storeProductCategoryID;
    map['productQuantity'] = productQuantity;
    map['status'] = productStatus;
    return map;
  }
}

class UpdateProductRequest {
  DataStoreUpdateProduct  dataStoreProduct;
  List<TranslateStoreUpdateProduct>? translate;

  UpdateProductRequest({required this.dataStoreProduct, this.translate});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['data'] = dataStoreProduct.toJson();
    if (translate != null) {
      map['translate'] = translate?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TranslateStoreUpdateProduct {
  String? productName;
  String? lang;
  int productID;

  TranslateStoreUpdateProduct({this.productName, this.lang ,required this.productID});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productName'] = productName;
    map['language'] = lang;
    map['productID'] = productID;
    return map;
  }
}

class UpdateProductStatusRequest {
  int id;
  String status;
  int storeProductCategoryID;
  int storeMainCategoryID;

  UpdateProductStatusRequest(
      {required this.id,
      required this.status,
      required this.storeProductCategoryID,
      required this.storeMainCategoryID});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    return map;
  }
}
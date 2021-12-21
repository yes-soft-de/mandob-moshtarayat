class DataStoreUpdateProduct {
  int? id;
  String? productName;
  String? productImage;
  num? discount;
  num? productQuantity;
  double? productPrice;
  int? storeOwnerProfileID;
  int? storeProductCategoryID;
  int? storeMainCategoryID;

  DataStoreUpdateProduct({
      this.id,
      this.productName,
      this.productImage,
      this.productPrice,
      this.discount,
      this.storeOwnerProfileID,
      this.storeProductCategoryID,
    this.productQuantity,
    this.storeMainCategoryID
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
    return map;
  }

}



class UpdateProductRequest {

  DataStoreUpdateProduct? dataStoreProduct;
  List<TranslateStoreUpdateProduct>? translate;

  UpdateProductRequest({
    this.dataStoreProduct, this.translate});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['data'] = dataStoreProduct?.toJson();
    if (translate != null) {
      map['translate'] = translate?.map((v) => v.toJson()).toList();
    }
    return map;
  }


}
class TranslateStoreUpdateProduct{
  String? productName;
  String? lang;

  TranslateStoreUpdateProduct({ this.productName, this.lang});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productName'] = productName;
    map['language'] = lang;
    return map;
  }
}


class UpdateProductStatusRequest{
  int id;
  String status;
  int storeProductCategoryID;
  int storeMainCategoryID;


  UpdateProductStatusRequest({required this.id, required this.status,required this.storeProductCategoryID ,required this.storeMainCategoryID});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    return map;
  }
}
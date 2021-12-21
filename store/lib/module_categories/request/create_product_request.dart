class DataStoreProduct {
  String? productName;
  String? productImage;
  String? description;
  num? productPrice;
  num? productQuantity;
  num? discount;
  int? storeProductCategoryID;

  DataStoreProduct({
      this.productName, 
      this.productImage, 
      this.productPrice,
    this.productQuantity,
      this.discount, this.description,
      this.storeProductCategoryID});

  DataStoreProduct.fromJson(dynamic json) {
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    productQuantity  = json['productQuantity'];
    discount = json['discount'];
    description = json['description'];
    storeProductCategoryID = json['storeProductCategoryID'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['productPrice'] = productPrice;
    map['productQuantity'] = productQuantity;
    map['discount'] = discount;
    map['description'] = description;
    map['storeProductCategoryID'] = storeProductCategoryID;
    return map;
  }

}
class CreateProductRequest {

  DataStoreProduct? dataStoreProduct;
  List<TranslateStoreProduct>? translate;

  CreateProductRequest({
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
class TranslateStoreProduct{
  String? productName;
  String? lang;

  TranslateStoreProduct({ this.productName, this.lang});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productName'] = productName;
    map['language'] = lang;
    return map;
  }
}
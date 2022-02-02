import 'product_image.dart';

class Product {
  String? productName;
  ProductImage? productImage;
  num? productPrice;
  int? countProduct;
  int? productCategoryId;
  String? orderNumber;
  int? productId;

  Product({
    this.productName,
    this.productImage,
    this.productPrice,
    this.countProduct,
    this.productCategoryId,
    this.orderNumber,
    this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productName: json['productName'] as String?,
        productImage: json['productImage'] == null
            ? null
            : ProductImage.fromJson(
                json['productImage'] as Map<String, dynamic>),
        productPrice: json['productPrice'] as num?,
        countProduct: json['countProduct'] as int?,
        productCategoryId: json['productCategoryID'] as int?,
        orderNumber: json['orderNumber'] as String?,
        productId: json['productID'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'productImage': productImage?.toJson(),
        'productPrice': productPrice,
        'countProduct': countProduct,
        'productCategoryID': productCategoryId,
        'orderNumber': orderNumber,
        'productID': productId,
      };
}

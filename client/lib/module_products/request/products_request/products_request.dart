import 'product_detail.dart';

class ProductsRequest {
  List<ProductDetail>? productDetails;

  ProductsRequest({this.productDetails});

  factory ProductsRequest.fromJson(Map<String, dynamic> json) {
    return ProductsRequest(
      productDetails: (json['productDetails'] as List<dynamic>?)
          ?.map((e) => ProductDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'productDetails': productDetails?.map((e) => e.toJson()).toList(),
      };
}

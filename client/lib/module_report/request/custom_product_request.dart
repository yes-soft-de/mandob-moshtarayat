class CustomProductRequest {
  String? productName;
  String? productImage;
  String? detail;

  CustomProductRequest({this.productName, this.productImage, this.detail});

  factory CustomProductRequest.fromJson(Map<String, dynamic> json) {
    return CustomProductRequest(
      productName: json['productName'] as String?,
      productImage: json['productImage'] as String?,
      detail: json['detail'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'productImage': productImage,
        'detail': detail,
      };
}

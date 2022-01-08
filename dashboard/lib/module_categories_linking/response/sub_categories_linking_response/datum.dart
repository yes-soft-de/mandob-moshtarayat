import 'product_category_image.dart';

class Datum {
  int? id;
  String? productCategoryName;
  ProductCategoryImage? productCategoryImage;
  bool? linked;

  Datum({
    this.id,
    this.productCategoryName,
    this.productCategoryImage,
    this.linked,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        productCategoryName: json['productCategoryName'] as String?,
        productCategoryImage: json['productCategoryImage'] == null
            ? null
            : ProductCategoryImage.fromJson(
                json['productCategoryImage'] as Map<String, dynamic>),
        linked: json['linked'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'productCategoryName': productCategoryName,
        'productCategoryImage': productCategoryImage?.toJson(),
        'linked': linked,
      };
}

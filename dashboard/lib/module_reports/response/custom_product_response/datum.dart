import 'product_image.dart';

class Datum {
  int? id;
  String? clientId;
  String? productName;
  ProductImage? productImage;
  String? detail;

  Datum({
    this.id,
    this.clientId,
    this.productName,
    this.productImage,
    this.detail,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        clientId: json['clientID'] as String?,
        productName: json['productName'] as String?,
        productImage: json['productImage'] == null
            ? null
            : ProductImage.fromJson(
                json['productImage'] as Map<String, dynamic>),
        detail: json['detail'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clientID': clientId,
        'productName': productName,
        'productImage': productImage?.toJson(),
        'detail': detail,
      };
}

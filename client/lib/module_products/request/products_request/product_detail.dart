class ProductDetail {
  int? id;
  int? quantity;

  ProductDetail({this.id, this.quantity});

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json['id'] as int?,
        quantity: json['quantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
      };
}

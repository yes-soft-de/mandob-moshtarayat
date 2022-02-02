import 'product.dart';

class Data {
  bool? attention;
  List<Product>? products;

  Data({this.attention, this.products});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attention: json['attention'] as bool?,
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'attention': attention,
        'products': products?.map((e) => e.toJson()).toList(),
      };
}

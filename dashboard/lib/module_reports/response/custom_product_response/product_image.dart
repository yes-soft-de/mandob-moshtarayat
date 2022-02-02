class ProductImage {
  String? imageUrl;
  String? image;
  String? baseUrl;

  ProductImage({this.imageUrl, this.image, this.baseUrl});

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        imageUrl: json['imageURL'] as String?,
        image: json['image'] as String?,
        baseUrl: json['baseURL'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'imageURL': imageUrl,
        'image': image,
        'baseURL': baseUrl,
      };
}

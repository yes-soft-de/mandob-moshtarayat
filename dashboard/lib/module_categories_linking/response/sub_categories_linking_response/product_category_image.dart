class ProductCategoryImage {
  String? image;
  String? imageUrl;
  String? baseUrl;

  ProductCategoryImage({this.image, this.imageUrl, this.baseUrl});

  factory ProductCategoryImage.fromJson(Map<String, dynamic> json) {
    return ProductCategoryImage(
      image: json['image'] as String?,
      imageUrl: json['imageURL'] as String?,
      baseUrl: json['baseURL'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'image': image,
        'imageURL': imageUrl,
        'baseURL': baseUrl,
      };
}

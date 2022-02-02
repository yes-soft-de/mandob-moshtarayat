class Image {
  String? image;
  String? imageUrl;
  String? baseUrl;

  Image({this.image, this.imageUrl, this.baseUrl});

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        image: json['image'] as String?,
        imageUrl: json['imageURL'] as String?,
        baseUrl: json['baseURL'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'imageURL': imageUrl,
        'baseURL': baseUrl,
      };
}

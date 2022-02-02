class Image {
  dynamic image;
  dynamic imageUrl;
  String? baseUrl;

  Image({this.image, this.imageUrl, this.baseUrl});

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        image: json['image'] as dynamic,
        imageUrl: json['imageURL'] as dynamic,
        baseUrl: json['baseURL'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'imageURL': imageUrl,
        'baseURL': baseUrl,
      };
}

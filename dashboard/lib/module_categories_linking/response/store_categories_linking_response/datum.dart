import 'image.dart';

class Datum {
  int? id;
  String? storeCategoryName;
  Image? image;
  bool? linked;

  Datum({this.id, this.storeCategoryName, this.image, this.linked});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        storeCategoryName: json['storeCategoryName'] as String?,
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
        linked: json['linked'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeCategoryName': storeCategoryName,
        'image': image?.toJson(),
        'linked': linked,
      };
}

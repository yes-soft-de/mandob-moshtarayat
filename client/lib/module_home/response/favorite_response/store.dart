import 'image.dart';

class Store {
  int? id;
  String? storeOwnerName;
  Image? image;
  String? phone;
  String? status;

  Store({
    this.id,
    this.storeOwnerName,
    this.image,
    this.phone,
    this.status,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json['id'] as int?,
        storeOwnerName: json['storeOwnerName'] as String?,
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
        phone: json['phone'] as String?,
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeOwnerName': storeOwnerName,
        'image': image?.toJson(),
        'phone': phone,
        'status': status,
      };
}

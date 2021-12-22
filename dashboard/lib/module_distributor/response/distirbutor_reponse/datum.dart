import 'image.dart';

class Datum {
  int? id;
  dynamic mandobId;
  String? mandobName;
  dynamic location;
  dynamic age;
  String? status;
  String? roomId;
  Image? image;
  dynamic phone;
  dynamic bankName;
  dynamic bankAccountNumber;
  dynamic stcPay;

  Datum({
    this.id,
    this.mandobId,
    this.mandobName,
    this.location,
    this.age,
    this.status,
    this.roomId,
    this.image,
    this.phone,
    this.bankName,
    this.bankAccountNumber,
    this.stcPay,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        mandobId: json['mandobID'] as dynamic?,
        mandobName: json['mandobName'] as String?,
        location: json['location'] as dynamic?,
        age: json['age'] as dynamic?,
        status: json['status'] as String?,
        roomId: json['roomID'] as String?,
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
        phone: json['phone'] as dynamic?,
        bankName: json['bankName'] as dynamic?,
        bankAccountNumber: json['bankAccountNumber'] as dynamic?,
        stcPay: json['stcPay'] as dynamic?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'mandobID': mandobId,
        'mandobName': mandobName,
        'location': location,
        'age': age,
        'status': status,
        'roomID': roomId,
        'image': image?.toJson(),
        'phone': phone,
        'bankName': bankName,
        'bankAccountNumber': bankAccountNumber,
        'stcPay': stcPay,
      };
}

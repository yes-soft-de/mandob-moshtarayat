import 'image.dart';

class Datum {
  int? id;
  dynamic mandobId;
  String? mandobName;

  num? age;
  String? status;

  Image? image;
  String? phone;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;

  Datum({
    this.id,
    this.mandobId,
    this.mandobName,

    this.age,
    this.status,

    this.image,
    this.phone,
    this.bankName,
    this.bankAccountNumber,
    this.stcPay,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        mandobId: json['mandobID']  ,
        mandobName: json['mandobName']  ,

        age: json['age']  ,
        status: json['status']  ,

        image: json['image'] == null
            ? null
            : Image.fromJson(json['image']),
        phone: json['phone']  ,
        bankName: json['bankName']  ,
        bankAccountNumber: json['bankAccountNumber']  ,
        stcPay: json['stcPay']  ,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'mandobID': mandobId,
        'mandobName': mandobName,

        'age': age,
        'status': status,

        'image': image?.toJson(),
        'phone': phone,
        'bankName': bankName,
        'bankAccountNumber': bankAccountNumber,
        'stcPay': stcPay,
      };
}

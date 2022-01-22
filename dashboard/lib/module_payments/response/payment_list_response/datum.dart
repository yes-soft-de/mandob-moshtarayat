import 'package:mandob_moshtarayat_dashboad/module_logs/response/captain_logs_response.dart';

class Datum {
  int? id;
  String? transactionId;
  String? token;
  num? amount;
  String? payStatus;
  CreatedAt? createdAt;
  CreatedAt? updatedAt;
  int? orderNumber;
  String? clientName;

  Datum({
    this.id,
    this.transactionId,
    this.token,
    this.amount,
    this.payStatus,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.clientName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        transactionId: json['transactionID'] as String?,
        token: json['token'] as String?,
        amount: json['amount'] as num?,
        payStatus: json['payStatus'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        updatedAt: json['updatedAt'] == null
            ? null
            : CreatedAt.fromJson(json['updatedAt'] as Map<String, dynamic>),
        orderNumber: json['orderNumber'] as int?,
        clientName: json['clientName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'transactionID': transactionId,
        'token': token,
        'amount': amount,
        'payStatus': payStatus,
        'createdAt': createdAt?.toJson(),
        'updatedAt': updatedAt?.toJson(),
        'orderNumber': orderNumber,
        'clientName': clientName,
      };
}

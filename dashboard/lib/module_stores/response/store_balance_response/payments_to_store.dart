import 'date.dart';

class PaymentsToStore {
  int? id;
  int? storeOwnerProfileId;
  int? amount;
  Date? date;
  String? note;

  PaymentsToStore({
    this.id,
    this.storeOwnerProfileId,
    this.amount,
    this.date,
    this.note,
  });

  factory PaymentsToStore.fromJson(Map<String, dynamic> json) {
    return PaymentsToStore(
      id: json['id'] as int?,
      storeOwnerProfileId: json['storeOwnerProfileID'] as int?,
      amount: json['amount'] as int?,
      date: json['date'] == null
          ? null
          : Date.fromJson(json['date'] as Map<String, dynamic>),
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeOwnerProfileID': storeOwnerProfileId,
        'amount': amount,
        'date': date?.toJson(),
        'note': note,
      };
}

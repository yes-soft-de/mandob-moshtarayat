class StorePaymentRequest {
  int? storeOwnerProfileId;
  num? amount;
  String? note;

  StorePaymentRequest({this.storeOwnerProfileId, this.amount, this.note});

  factory StorePaymentRequest.fromJson(Map<String, dynamic> json) {
    return StorePaymentRequest(
      storeOwnerProfileId: json['storeOwnerProfileID'] as int?,
      amount: json['amount'] as num?,
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'storeOwnerProfileID': storeOwnerProfileId,
        'amount': amount,
        'note': note,
      };
}

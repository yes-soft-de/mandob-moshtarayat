class CreatePaymentRecordRequest {
  int? orderNumber;
  String? transactionId;
  String? state;
  String? token;
  double? amount;
  CreatePaymentRecordRequest(
      {this.orderNumber,
      this.transactionId,
      this.state,
      this.token,
      this.amount});

  factory CreatePaymentRecordRequest.fromJson(Map<String, dynamic> json) {
    return CreatePaymentRecordRequest(
        orderNumber: json['orderNumber'] as int?,
        transactionId: json['transactionID'] as String?,
        state: json['payStatus'] as String?,
        token: json['token'] as String?,
        amount: json['amount'] as double?);
  }

  Map<String, dynamic> toJson() => {
        'orderNumber': orderNumber,
        'transactionID': transactionId,
        'payStatus': state,
        'token': token,
        'amount': amount
      };
}

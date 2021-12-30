class CreatePaymentRecordRequest {
  int? orderNumber;
  String? transactionId;
  String? state;
  String? token;

  CreatePaymentRecordRequest({
    this.orderNumber,
    this.transactionId,
    this.state,
    this.token,
  });

  factory CreatePaymentRecordRequest.fromJson(Map<String, dynamic> json) {
    return CreatePaymentRecordRequest(
      orderNumber: json['orderNumber'] as int?,
      transactionId: json['transactionID'] as String?,
      state: json['state'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'orderNumber': orderNumber,
        'transactionID': transactionId,
        'state': state,
        'token': token,
      };
}

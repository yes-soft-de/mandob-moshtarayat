class CaptainPaymentsRequest {
  int? captainId;
  num? amount;

  CaptainPaymentsRequest({
      this.captainId, 
      this.amount});

  CaptainPaymentsRequest.fromJson(dynamic json) {
    captainId = json['captainId'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['captainId'] = captainId;
    map['amount'] = amount;
    return map;
  }

}
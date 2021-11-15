class CaptainPaymentsRequest {
  int? captainId;
  num? amount;
  String? note;
  CaptainPaymentsRequest({
      this.captainId, 
      this.amount,
      this.note
   });

  CaptainPaymentsRequest.fromJson(dynamic json) {
    captainId = json['captainId'];
    amount = json['amount'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['captainId'] = captainId;
    map['amount'] = amount;
    map['note'] = note;
    return map;
  }

}
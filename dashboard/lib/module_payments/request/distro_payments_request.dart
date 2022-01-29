class DistroPaymentsRequest {
  int? representativeID;
  num? amount;
  String? note;
  DistroPaymentsRequest({this.representativeID, this.amount, this.note});

  DistroPaymentsRequest.fromJson(dynamic json) {
    representativeID = json['representativeID'];
    amount = json['amount'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['representativeID'] = representativeID;
    map['amount'] = amount;
    map['note'] = note;
    return map;
  }
}

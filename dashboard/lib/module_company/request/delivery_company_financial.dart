class DeliveryCompanyFinancialRequest {
  int? id;
  String? deliveryCost;
  String? representativeCommission;

  DeliveryCompanyFinancialRequest({this.id, this.deliveryCost,this.representativeCommission});

  DeliveryCompanyFinancialRequest.fromJson(dynamic json) {
    id = json['id'];
    deliveryCost = json['deliveryCost'];
    representativeCommission = json['representativeCommission'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['deliveryCost'] = deliveryCost;
    map['representativeCommission'] = representativeCommission;
    return map;
  }
}

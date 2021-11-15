class DeliveryCompanyFinancialRequest {
  int? id;
  String? deliveryCost;

  DeliveryCompanyFinancialRequest({
      this.id, 
      this.deliveryCost});

  DeliveryCompanyFinancialRequest.fromJson(dynamic json) {
    id = json['id'];
    deliveryCost = json['deliveryCost'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (id != null){
      map['id'] = id;
    }
    map['deliveryCost'] = deliveryCost;
    return map;
  }

}
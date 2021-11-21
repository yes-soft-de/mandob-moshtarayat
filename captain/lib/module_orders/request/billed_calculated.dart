class BilledCalculatedRequest {
  BilledCalculatedRequest({
      this.orderNumber, 
      this.isBillCalculated,});

  BilledCalculatedRequest.fromJson(dynamic json) {
    orderNumber = json['orderNumber'];
    isBillCalculated = json['isBillCalculated'];
  }
  String? orderNumber;
  int? isBillCalculated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderNumber'] = orderNumber;
    map['isBillCalculated'] = isBillCalculated;
    return map;
  }

}
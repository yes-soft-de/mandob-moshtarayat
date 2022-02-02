class UpdateOrderRequest {
  int? id;
  String? state;
  String? distance;
  double? orderCost;
  String? storeID;
  UpdateOrderRequest(
      {required this.id,
      required this.state,
      this.distance,
      required this.orderCost,this.storeID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderNumber'] = this.id.toString();
    data['state'] = this.state;
    data['deliveryCost'] = this.orderCost;
    if (this.storeID != null){
    data['storeOwnerProfileID'] = this.storeID;
    }
    if (distance != null) {
      data['kilometer'] = double.tryParse(this.distance ?? '0');
    }
    return data;
  }
}

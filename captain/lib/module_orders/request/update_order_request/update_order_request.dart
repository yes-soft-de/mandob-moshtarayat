class UpdateOrderRequest {
  int? id;
  String? state;
  String? distance;
  double? orderCost;
  UpdateOrderRequest({
  required  this.id,
  required  this.state,
    this.distance,
  required  this.orderCost
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderNumber'] = this.id.toString();
    data['state'] = this.state;
    data['deliveryCost'] = this.orderCost;
    if (distance != null) {
      data['kilometer'] = double.tryParse(this.distance??'0');
    }
    return data;
  }
}

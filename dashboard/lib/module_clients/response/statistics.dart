class Statistics {
  Statistics({
      this.clientOrdersCount, 
      this.clientOrdersCancel, 
      this.clientOrdersDelivered,});

  Statistics.fromJson(dynamic json) {
    clientOrdersCount = json['clientOrdersCount'];
    clientOrdersCancel = json['clientOrdersCancel'];
    clientOrdersDelivered = json['clientOrdersDelivered'];
  }
  String? clientOrdersCount;
  String? clientOrdersCancel;
  String? clientOrdersDelivered;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clientOrdersCount'] = clientOrdersCount;
    map['clientOrdersCancel'] = clientOrdersCancel;
    map['clientOrdersDelivered'] = clientOrdersDelivered;
    return map;
  }

}
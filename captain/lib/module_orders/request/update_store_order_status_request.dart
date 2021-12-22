class UpdateStoreOrderStatusRequest {
  int? orderNumber;
  String? state;
  int? storeOwnerProfileId;

  UpdateStoreOrderStatusRequest({
    this.orderNumber,
    this.state,
    this.storeOwnerProfileId,
  });

  factory UpdateStoreOrderStatusRequest.fromJson(Map<String, dynamic> json) {
    return UpdateStoreOrderStatusRequest(
      orderNumber: json['orderNumber'] as int?,
      state: json['state'] as String?,
      storeOwnerProfileId: json['storeOwnerProfileID'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'orderNumber': orderNumber,
        'state': state,
        'storeOwnerProfileID': storeOwnerProfileId,
      };
}

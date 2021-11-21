class OrderInvoiceRequest {
  String? orderNumber;
  double? invoiceAmount;
  String? invoiceImage;
  int? isBilled;
  OrderInvoiceRequest({
      this.orderNumber, 
      this.invoiceAmount, 
      this.invoiceImage,
      this.isBilled
  });

  OrderInvoiceRequest.fromJson(dynamic json) {
    orderNumber = json['orderNumber'];
    invoiceAmount = json['invoiceAmount'];
    invoiceImage = json['invoiceImage'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['orderNumber'] = orderNumber;
    map['invoiceAmount'] = invoiceAmount;
    map['invoiceImage'] = invoiceImage;
    return map;
  }

}
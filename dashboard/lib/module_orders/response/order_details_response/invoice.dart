class Invoice {
  int? id;
  int? invoiceAmount;

  Invoice({this.id, this.invoiceAmount});

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json['id'] as int?,
        invoiceAmount: json['invoiceAmount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoiceAmount': invoiceAmount,
      };
}

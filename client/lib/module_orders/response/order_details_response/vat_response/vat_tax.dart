class VatTax {
  int? itemsTotal;
  double? vatTax;
  double? total;

  VatTax({this.itemsTotal, this.vatTax, this.total});

  factory VatTax.fromJson(Map<String, dynamic> json) => VatTax(
        itemsTotal: json['itemsTotal'] as int?,
        vatTax: (json['vatTax'] as num?)?.toDouble(),
        total: (json['total'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'itemsTotal': itemsTotal,
        'vatTax': vatTax,
        'total': total,
      };
}

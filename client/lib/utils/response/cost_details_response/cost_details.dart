class CostDetails {
  num? price;
  num? discount;
  num? priceWithDiscount;
  num? priceWithCommission;
  num? priceWithCommissionAfterDiscount;
  num? priceFinal;
  num? commission;

  CostDetails({
    this.price,
    this.discount,
    this.priceWithDiscount,
    this.priceWithCommission,
    this.priceWithCommissionAfterDiscount,
    this.priceFinal,
    this.commission,
  });

  factory CostDetails.fromJson(Map<String, dynamic> json) => CostDetails(
        price: json['price'] as num?,
        discount: json['discount'] as num?,
        priceWithDiscount: json['priceWithDiscount'] as num?,
        priceWithCommission: (json['priceWithCommission'] as num?)?.toDouble(),
        priceWithCommissionAfterDiscount:
            (json['priceWithCommissionAfterDiscount'] as num?)?.toDouble(),
        priceFinal: (json['priceFinal'] as num?)?.toDouble(),
        commission: json['commission'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'price': price,
        'discount': discount,
        'priceWithDiscount': priceWithDiscount,
        'priceWithCommission': priceWithCommission,
        'priceWithCommissionAfterDiscount': priceWithCommissionAfterDiscount,
        'priceFinal': priceFinal,
        'commission': commission,
      };
}

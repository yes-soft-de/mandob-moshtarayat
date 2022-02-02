class CostDetailsResponse {
  num? price;
  num? discount;
  num? priceWithDiscount;
  num? priceWithCommission;
  num? priceWithCommissionAfterDiscount;
  num? priceFinal;
  num? commission;

  CostDetailsResponse({
    this.price,
    this.discount,
    this.priceWithDiscount,
    this.priceWithCommission,
    this.priceWithCommissionAfterDiscount,
    this.priceFinal,
    this.commission,
  });

  factory CostDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CostDetailsResponse(
      price: json['price'] as num?,
      discount: json['discount'] as num?,
      priceWithDiscount: json['priceWithDiscount'] as num?,
      priceWithCommission: json['priceWithCommission'] as num?,
      priceWithCommissionAfterDiscount:
          json['priceWithCommissionAfterDiscount'] as num?,
      priceFinal: json['priceFinal'] as num?,
      commission: json['commission'] as num?,
    );
  }

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

class PayTabsRequest {
  PayTabsRequest({
      this.profileId, 
      this.tranType, 
      this.tranClass, 
      this.cartDescription, 
      this.cartId, 
      this.cartCurrency, 
      this.cartAmount, 
      this.callback, 
      this.returns,
      this.cardDetails,});

  PayTabsRequest.fromJson(dynamic json) {
    profileId = json['profile_id'];
    tranType = json['tran_type'];
    tranClass = json['tran_class'];
    cartDescription = json['cart_description'];
    cartId = json['cart_id'];
    cartCurrency = json['cart_currency'];
    cartAmount = json['cart_amount'];
    callback = json['callback'];
    returns = json['return'];
    cardDetails = json['card_details'] != null ? Card_details.fromJson(json['cardDetails']) : null;
  }
  String? profileId;
  String? tranType;
  String? tranClass;
  String? cartDescription;
  String? cartId;
  String? cartCurrency;
  double? cartAmount;
  String? callback;
  String? returns;
  Card_details? cardDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile_id'] = profileId;
    map['tran_type'] = tranType;
    map['tran_class'] = tranClass;
    map['cart_description'] = cartDescription;
    map['cart_id'] = cartId;
    map['cart_currency'] = cartCurrency;
    map['cart_amount'] = cartAmount;
    map['callback'] = callback;
    map['return'] = returns;
    if (cardDetails != null) {
      map['card_details'] = cardDetails?.toJson();
    }
    return map;
  }

}

class Card_details {
  Card_details({
      this.pan, 
      this.expiryMonth, 
      this.expiryYear, 
      this.cvv,});

  Card_details.fromJson(dynamic json) {
    pan = json['pan'];
    expiryMonth = json['expiry_month'];
    expiryYear = json['expiry_year'];
    cvv = json['cvv'];
  }
  String? pan;
  String? expiryMonth;
  String? expiryYear;
  String? cvv;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pan'] = pan;
    map['expiry_month'] = expiryMonth;
    map['expiry_year'] = expiryYear;
    map['cvv'] = cvv;
    return map;
  }

}
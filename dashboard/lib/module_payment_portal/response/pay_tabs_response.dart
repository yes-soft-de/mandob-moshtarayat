class PayTabsResponse {
  PayTabsResponse({
      this.tranRef, 
      this.cartId, 
      this.cartDescription, 
      this.cartCurrency, 
      this.cartAmount, 
      this.customerDetails, 
      this.paymentResult, 
      this.paymentInfo, 
      this.redirectUrl,});

  PayTabsResponse.fromJson(dynamic json) {
    tranRef = json['tran_ref'];
    cartId = json['cart_id'];
    cartDescription = json['cart_description'];
    cartCurrency = json['cart_currency'];
    cartAmount = json['cart_amount'];
    customerDetails = json['customer_details'] != null ? Customer_details.fromJson(json['customerDetails']) : null;
    paymentResult = json['payment_result'] != null ? Payment_result.fromJson(json['paymentResult']) : null;
    paymentInfo = json['payment_info'] != null ? Payment_info.fromJson(json['paymentInfo']) : null;
    redirectUrl = json['redirect_url'];
  }
  String? tranRef;
  String? cartId;
  String? cartDescription;
  String? cartCurrency;
  String? cartAmount;
  Customer_details? customerDetails;
  Payment_result? paymentResult;
  Payment_info? paymentInfo;
  String? redirectUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tran_ref'] = tranRef;
    map['cart_id'] = cartId;
    map['cart_description'] = cartDescription;
    map['cart_currency'] = cartCurrency;
    map['cart_amount'] = cartAmount;
    if (customerDetails != null) {
      map['customer_details'] = customerDetails?.toJson();
    }
    if (paymentResult != null) {
      map['payment_result'] = paymentResult?.toJson();
    }
    if (paymentInfo != null) {
      map['payment_info'] = paymentInfo?.toJson();
    }
    map['redirect_url'] = redirectUrl;
    return map;
  }

}

class Payment_info {
  Payment_info({
      this.cardType, 
      this.cardScheme, 
      this.paymentDescription,});

  Payment_info.fromJson(dynamic json) {
    cardType = json['card_type'];
    cardScheme = json['card_scheme'];
    paymentDescription = json['payment_description'];
  }
  String? cardType;
  String? cardScheme;
  String? paymentDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['card_type'] = cardType;
    map['card_scheme'] = cardScheme;
    map['payment_description'] = paymentDescription;
    return map;
  }

}

class Payment_result {
  Payment_result({
      this.responseStatus, 
      this.responseCode, 
      this.responseMessage, 
      this.acquirerMessage, 
      this.acquirerRrn, 
      this.transactionTime,});

  Payment_result.fromJson(dynamic json) {
    responseStatus = json['response_status'];
    responseCode = json['response_code'];
    responseMessage = json['response_message'];
    acquirerMessage = json['acquirer_message'];
    acquirerRrn = json['acquirer_rrn'];
    transactionTime = json['transaction_time'];
  }
  String? responseStatus;
  String? responseCode;
  String? responseMessage;
  String? acquirerMessage;
  String? acquirerRrn;
  String? transactionTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_status'] = responseStatus;
    map['response_code'] = responseCode;
    map['response_message'] = responseMessage;
    map['acquirer_message'] = acquirerMessage;
    map['acquirer_rrn'] = acquirerRrn;
    map['transaction_time'] = transactionTime;
    return map;
  }

}

class Customer_details {
  Customer_details({
      this.name, 
      this.email, 
      this.phone, 
      this.street1, 
      this.city, 
      this.state, 
      this.country, 
      this.ip,});

  Customer_details.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    street1 = json['street1'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    ip = json['ip'];
  }
  String? name;
  String? email;
  String? phone;
  String? street1;
  String? city;
  String? state;
  String? country;
  String? ip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['street1'] = street1;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['ip'] = ip;
    return map;
  }

}
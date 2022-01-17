class CreateMandobRequest {
  int? id;
  String? mandobName;
  String? image;
  int? age;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  String? phone;

  CreateMandobRequest({
    this.id,
    this.mandobName,
    this.image,
    this.age,
    this.bankName,
    this.bankAccountNumber,
    this.stcPay,
    this.phone,
  });


  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id']= id;
    map['mandobName'] = mandobName;
    map['phone'] = phone;
    map['image'] = image;
    map['bankName'] = bankName;
    map['bankAccountNumber'] = bankAccountNumber;
    map['stcPay'] = stcPay;
    map['age'] = age;
    return map;
  }

}
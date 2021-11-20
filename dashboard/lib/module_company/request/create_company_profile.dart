class CreateCompanyProfile {
  String? phone;
  String? phone2;
  String? whatsapp;
  String? fax;
  String? bank;
  String? stc;
  String? email;
  double? deliveryCost;

  CreateCompanyProfile({
      this.phone, 
      this.phone2, 
      this.whatsapp, 
      this.fax, 
      this.bank, 
      this.stc, 
      this.email, 
      this.deliveryCost});

  CreateCompanyProfile.fromJson(dynamic json) {
    phone = json['phone'];
    phone2 = json['phone2'];
    whatsapp = json['whatsapp'];
    fax = json['fax'];
    bank = json['bank'];
    stc = json['stc'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['phone'] = phone;
    map['phone2'] = phone2;
    map['whatsapp'] = whatsapp;
    map['fax'] = fax;
    map['bank'] = bank;
    map['stc'] = stc;
    map['email'] = email;
    return map;
  }

}
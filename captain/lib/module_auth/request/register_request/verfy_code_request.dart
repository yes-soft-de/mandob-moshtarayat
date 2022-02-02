

import 'package:mandob_moshtarayat_captain/consts/country_code.dart';

class VerifyCodeRequest {
  String userID;
  String? code;
  String? password;

  VerifyCodeRequest({required this.userID,this.code,this.password});

//  VerifyCodeRequest.fromJson(Map<String, dynamic> json) {
//    userID = json['userID'];
//    code = json['code'];
//  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = CountryCode.COUNTRY_CODE_KSA + userID;
    if (code != null) {
    data['code'] = code;
    }
    return data;
  }
}
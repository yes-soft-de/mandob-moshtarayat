import 'package:mandob_moshtarayat/consts/country_code.dart';

class LoginRequest {
  String username;
  String? password;

  LoginRequest({required this.username, this.password});

//  LoginRequest.fromJson(Map<String, dynamic> json) {
//    username = json['username'];
//    password = json['password'];
//  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] =CountryCode.COUNTRY_CODE+ this.username;
    data['password'] = this.password;
    return data;
  }
}

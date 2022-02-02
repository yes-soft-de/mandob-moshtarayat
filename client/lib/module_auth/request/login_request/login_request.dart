import 'package:mandob_moshtarayat/consts/country_code.dart';

class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = CountryCode.COUNTRY_CODE_KSA + username.toString();
    data['password'] = this.password;
    return data;
  }
}

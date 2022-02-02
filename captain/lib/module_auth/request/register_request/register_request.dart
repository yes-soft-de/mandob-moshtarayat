import 'package:mandob_moshtarayat_captain/consts/country_code.dart';

class RegisterRequest {
  String? userID;
  String? password;
  String? userName;

  RegisterRequest({this.userID, this.password, this.userName});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = CountryCode.COUNTRY_CODE_KSA + userID.toString();
    data['password'] = this.password;
    data['userName'] = this.userName;
    return data;
  }
}

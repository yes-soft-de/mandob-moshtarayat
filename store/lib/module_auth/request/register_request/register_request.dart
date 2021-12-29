import 'package:mandob_moshtarayat/consts/country_code.dart';

class RegisterRequest {
  String userID;
  String? password;
  String? userName;

  RegisterRequest({required this.userID, this.password, this.userName});

//  RegisterRequest.fromJson(Map<String, dynamic> json) {
//    userID = json['userID'];
//    password = json['password'];
//  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = CountryCode.COUNTRY_CODE+ this.userID;
    data['password'] = this.password;
    data['userName'] = this.userName;
    return data;
  }
}

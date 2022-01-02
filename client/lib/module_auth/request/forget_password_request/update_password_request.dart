import 'package:mandob_moshtarayat/consts/country_code.dart';

class UpdatePassRequest {
  String userID;
  String newPassword;

  UpdatePassRequest({required this.userID, required this.newPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = CountryCode.COUNTRY_CODE_KSA + this.userID;
    data['password'] = this.newPassword;
    return data;
  }
}

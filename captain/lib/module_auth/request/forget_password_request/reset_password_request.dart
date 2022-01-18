import 'package:mandob_moshtarayat_captain/consts/country_code.dart';

class ResetPassRequest {
  String userID;
  String? role;
  ResetPassRequest({required this.userID, this.role});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = CountryCode.COUNTRY_CODE_KSA + this.userID;
    if (role != null) {
      data['role'] = role;
    }
    return data;
  }
}

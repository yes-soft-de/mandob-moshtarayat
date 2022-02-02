import 'package:mandob_moshtarayat/consts/country_code.dart';

class ResetPassRequest {
  String userID;
  String? role;
  ResetPassRequest({required this.userID, this.role});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = CountryCode.COUNTRY_CODE + this.userID;
    if (role != null) {
      data['role'] = role;
    }
    return data;
  }
}

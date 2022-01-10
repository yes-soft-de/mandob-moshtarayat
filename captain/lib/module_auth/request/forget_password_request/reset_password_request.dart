import 'package:mandob_moshtarayat_captain/consts/country_code.dart';

class ResetPassRequest {
  String userID;

  ResetPassRequest({required this.userID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = CountryCode.COUNTRY_CODE_KSA + this.userID;
    return data;
  }
}

import 'package:mandob_moshtarayat/consts/country_code.dart';

class ResetPassRequest {
  String userID;

  ResetPassRequest({required this.userID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] =CountryCode.COUNTRY_CODE+ this.userID;
    return data;
  }
}
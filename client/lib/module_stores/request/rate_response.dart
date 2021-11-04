import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class RateResponse {
  String? statusCode;
  String? msg;
  dynamic data;

  RateResponse({this.statusCode, this.msg, this.data});

  RateResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'];
    } catch (e) {
      Logger().error('Rate Response', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
  }
}

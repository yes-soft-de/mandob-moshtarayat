import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class SendItResponse {
  String? statusCode;
  String? msg;
  dynamic data;

  SendItResponse({this.statusCode, this.msg, this.data});

  SendItResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'];
    } catch (e) {
      Logger().error('Send It response', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
  }
}

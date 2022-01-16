import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class CreateCaptainProfileResponse {
  String? statusCode;
  String? msg;
  dynamic data;

  CreateCaptainProfileResponse({this.statusCode, this.msg, this.data});

  CreateCaptainProfileResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'];
    } catch (e) {
      Logger().error(
          'Create Mandob Profile Response', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
  }
}

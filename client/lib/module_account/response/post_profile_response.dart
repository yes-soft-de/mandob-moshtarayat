import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class PostProfilerResponse {
  String? statusCode;
  String? msg;
  dynamic data;

  PostProfilerResponse({this.statusCode, this.msg, this.data});

  PostProfilerResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'];
    } catch (e) {
      Logger().error(
          'Post Profile Response', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
  }
}

import 'package:mandob_moshtarayat/utils/logger/logger.dart';

class ClientOrderResponse {
  String? statusCode;
  String? msg;
  dynamic data;

  ClientOrderResponse({this.statusCode, this.msg, this.data});

  ClientOrderResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'];
    } catch (e) {
      Logger().error(
          'Client Order Response', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
  }
}

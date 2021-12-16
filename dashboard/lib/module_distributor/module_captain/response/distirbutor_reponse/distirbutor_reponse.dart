import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

import 'datum.dart';

class DistirbutorReponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  DistirbutorReponse({this.statusCode, this.msg, this.data});

  factory DistirbutorReponse.fromJson(Map<String, dynamic> json) {
    try {
      return DistirbutorReponse(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data: (json['Data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      Logger().error('Distirbutor Response',e.toString(),StackTrace.current);
      return DistirbutorReponse(
        statusCode: '-1',
        msg: json['msg'] as String?,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': data?.map((e) => e.toJson()).toList(),
      };
}

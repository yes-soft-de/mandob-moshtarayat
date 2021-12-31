import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

import 'datum.dart';

class DistributorResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  DistributorResponse({this.statusCode, this.msg, this.data});

  factory DistributorResponse.fromJson(Map<String, dynamic> json) {
    try {
      return DistributorResponse(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data: (json['Data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      Logger().error('Distirbutor Response', e.toString(), StackTrace.current);
      return DistributorResponse(
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

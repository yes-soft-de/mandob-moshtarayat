import 'datum.dart';

class SubCategoriesLinkingResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  SubCategoriesLinkingResponse({this.statusCode, this.msg, this.data});

  factory SubCategoriesLinkingResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoriesLinkingResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: (json['Data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': data?.map((e) => e.toJson()).toList(),
      };
}

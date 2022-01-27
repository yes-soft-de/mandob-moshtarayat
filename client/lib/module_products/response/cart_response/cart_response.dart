import 'data.dart';

class CartResponse {
  String? message;
  String? statusCode;
  Data? data;

  CartResponse({this.message, this.statusCode, this.data});

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        message: json['message'] as String?,
        statusCode: json['status_code'] as String?,
        data: json['Data'] == null
            ? null
            : Data.fromJson(json['Data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'status_code': statusCode,
        'Data': data?.toJson(),
      };
}

class VerifyResetPassCodeRequest {
  String code;

  VerifyResetPassCodeRequest({required this.code});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    return data;
  }
}

import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';

class StatusCodeHelper {
  static String getStatusCodeMessages(var statusCode) {
    if (statusCode is int) {
      statusCode = statusCode.toString();
    }
    statusCode ??= '0';
    switch (statusCode) {
      case '200':
        return S.current.statusCodeOk;
      case '201':
        return S.current.statusCodeCreated;
      case '400':
        return S.current.statusCodeBadRequest;
      case '401':
        return S.current.statusCodeUnauthorized;
      case '404':
        return S.current.StatusCodeNotFound;
      case '500':
        return S.current.internalServerError;
      case '9000':
        return S.current.invalidCredentials;
      case '9001':
        return S.current.accountAlreadyExist;
      case '9201':
        return S.current.errorDeleteCategory;
      case '9251':
        return S.current.errorDeleteCategory;
      case '-1':
        return S.current.dataDecodeError;
      default:
        return S.current.errorHappened;
    }
  }
}

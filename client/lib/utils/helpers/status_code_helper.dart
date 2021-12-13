import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/global_nav_key.dart';
import 'package:mandob_moshtarayat/module_auth/presistance/auth_prefs_helper.dart';
import 'package:mandob_moshtarayat/module_splash/splash_routes.dart';

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
        AuthPrefsHelper().cleanAll();
        Navigator.of(GlobalVariable.navState.currentContext!).pushNamedAndRemoveUntil(
            SplashRoutes.SPLASH_SCREEN, (route) => false);
        return S.current.statusCodeUnauthorized;
      case '404':
        return S.current.StatusCodeNotFound;
        case '405':
        return S.current.statusCodeBadRequest;
      case '500':
        return S.current.internalServerError;
      case '9000':
        return S.current.invalidCredentials;
      case '9001':
        return S.current.accountAlreadyExist;
      case '-1':
        return S.current.dataDecodeError;
      default:
        return S.current.errorHappened;
    }
  }
}

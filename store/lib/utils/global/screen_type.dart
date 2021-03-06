import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/global_nav_key.dart';

class ScreenType {
  static String getCurrentScreenType() {
    var screenSize =
        MediaQuery.of(GlobalVariable.navState.currentContext!).size;

    if (screenSize.width >= 1200) {
      return 'Desktop';
    }
    if (screenSize.width >= 600) {
      return 'Tablet';
    }
    if (screenSize.width >= 250) {
      return 'Mobile';
    } else {
      return 'Watch';
    }
  }

  static bool isMobile() {
    var screenSize =
        MediaQuery.of(GlobalVariable.navState.currentContext!).size;
    if (screenSize.width < 600) {
      return true;
    } else {
      return false;
    }
  }

  static bool isDesktop([BuildContext? context]) {
    var screenSize =
        MediaQuery.of(context ?? GlobalVariable.navState.currentContext!).size;
    if (screenSize.width >= 1200) {
      return true;
    } else {
      return false;
    }
  }

  static bool isTablet() {
    var screenSize =
        MediaQuery.of(GlobalVariable.navState.currentContext!).size;
    if (screenSize.width > 600 && screenSize.width < 1200) {
      return true;
    } else {
      return false;
    }
  }
}

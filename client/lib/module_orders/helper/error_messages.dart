import 'package:mandob_moshtarayat/generated/l10n.dart';

class ErrorMessages {
  static String getDeleteMessage(String err) {
    if (err == 'order Number not found!!') {
      return S.current.orderNumberNotFound;
    } else if (err == 'can not remove it, Exceeded time allowed') {
      return S.current.exceededAllowedTime;
    } else if (err == 'can not remove it, The captain received the order') {
      return S.current.notAllowedCaptainReceived;
    } else if (err == "you can't edit, captain in the store.") {
      return S.current.notAllowedCaptainInStore;
    } else {
      return S.current.errorHappened;
    }
  }
}

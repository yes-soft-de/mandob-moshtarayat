import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationsPrefHelper {
  var box = Hive.box('Notification');

  void setIsActive(bool active) {
    box.put('client_active', active);
  }

  bool? getIsActive() {
    return box.get('client_active');
  }

  RemoteMessage getBackgroundMessage() {
    return box.get('BackgroundMessage');
  }

  void setBackgroundMessage(RemoteMessage message) {
    box.put('BackgroundMessage', message);
  }
}

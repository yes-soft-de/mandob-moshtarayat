import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:mandob_moshtarayat_dashboad/module_notifications/repository/notification_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/subjects.dart';
import 'package:mandob_moshtarayat_dashboad/utils/logger/logger.dart';

@injectable
class FireNotificationService {
  final NotificationsPrefsHelper _prefsHelper;
  final NotificationRepo _notificationRepo;

  FireNotificationService(
    this._prefsHelper,
    this._notificationRepo,
  );

  static final PublishSubject<RemoteMessage> _onNotificationRecieved =
      PublishSubject();

  Stream get onNotificationStream => _onNotificationRecieved.stream;

  static StreamSubscription? iosSubscription;

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    await _fcm.requestPermission();
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    var isActive = await _prefsHelper.getIsActive();
    await refreshNotificationToken();
    await setCaptainActive(isActive == true);
  }

  Future<void> refreshNotificationToken() async {
    var token = await _fcm.getToken();
    if (token != null) {
      // And Subscribe to the changes
      try {
        //_notificationRepo.postToken(token);
      } catch (e) {}
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        Logger().info('FireNotificationService', 'onMessage: $message');
        _onNotificationRecieved.add(message);
      });
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    }
  }

  Future<void> setCaptainActive(bool active) async {
    await _prefsHelper.setIsActive(active);
    if (active) {
      await _fcm.subscribeToTopic('captains');
    } else {
      await _fcm.unsubscribeFromTopic('captains');
    }
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    Logger().info('FireNotificationService', 'onMessage: $message');
    _onNotificationRecieved.add(message);
  }
}

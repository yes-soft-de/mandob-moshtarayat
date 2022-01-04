import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/global_nav_key.dart';
import 'package:mandob_moshtarayat/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:mandob_moshtarayat/module_notifications/repository/notification_repo.dart';
import 'package:mandob_moshtarayat/utils/logger/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';

@injectable
class FireNotificationService {
  final NotificationsPrefHelper _prefHelper;
  final NotificationRepo _notificationRepo;

  FireNotificationService(
    this._prefHelper,
    this._notificationRepo,
  );

  static final PublishSubject<RemoteMessage> _onNotificationReceived =
      PublishSubject();

  Stream get onNotificationStream => _onNotificationReceived.stream;

  static StreamSubscription? iosSubscription;

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    await _fcm.requestPermission();
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // var isActive = _prefHelper.getIsActive();
    await refreshNotificationToken();
  }

  Future<void> refreshNotificationToken() async {
    var token = await _fcm.getToken();
    if (token != null) {
      // And Subscribe to the changes
      try {
        _notificationRepo.postToken(token);
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          Logger().info('FireNotificationService', 'onMessage: $message');
          SchedulerBinding.instance?.addPostFrameCallback(
            (_) {
              Navigator.pushNamed(GlobalVariable.navState.currentContext!,
                  message.data['navigate_route'].toString(),
                  arguments: message.data['argument']);
            },
          );
        });
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          _onNotificationReceived.add(message);
        });
        FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  static Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
    print('AppPush myBackgroundMessageHandler : $message');
    NotificationsPrefHelper().setBackgroundMessage(message);
    _onNotificationReceived.add(message);
    return Future<void>.value();
  }
}

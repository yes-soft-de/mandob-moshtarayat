import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_notifications/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final PublishSubject<String> _onNotificationRecieved =
      PublishSubject();

  Stream get onLocalNotificationStream => _onNotificationRecieved.stream;

  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(requestSoundPermission: true);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void showNotification(RemoteMessage message) {
    RemoteNotification notification = message.notification!;
    IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('${message.messageId}',
            'mandob_moshtarayat_dashboad', 'delivery app',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
        int.tryParse(message.messageId ?? '1') ?? 1,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: null);
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      _onNotificationRecieved.add(payload);
    }
  }
}

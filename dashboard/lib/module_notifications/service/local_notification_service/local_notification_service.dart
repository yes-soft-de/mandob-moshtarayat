import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final PublishSubject<String> _onNotificationReceived =
      PublishSubject();

  Stream get onLocalNotificationStream => _onNotificationReceived.stream;

  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('icon');

    const IOSInitializationSettings initializationSettingsIOS =
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
        const IOSNotificationDetails();

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'Local_notification',
      'Local Notification',
      'Showing notifications while the app running',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: true,
      playSound: true,
      channelShowBadge: true,
      enableLights: true,
      enableVibration: true,
      onlyAlertOnce: false,
      category: 'Local',
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
        int.tryParse(message.messageId ?? '1') ?? Random().nextInt(1000000),
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: json.encode(message.data));
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      var data = json.decode(payload);
      _onNotificationReceived.add(data);
    }
  }
}

import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_my_notifications/repository/my_notifications_repository.dart';
import 'package:mandob_moshtarayat/module_my_notifications/response/my_notification_response.dart';

@injectable
class MyNotificationsManager {
  final MyNotificationsRepository _myNotificationsRepository;

  MyNotificationsManager(this._myNotificationsRepository);

  Future<MyNotificationResponse?> getNotification() =>
      _myNotificationsRepository.getMyNotification();
}

import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_my_notifications/response/my_notification_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/date_converter.dart';

class NotificationModel {
  String orderNumber = '-1';
  String body = S.current.orderDetails;
  String title = S.current.orderNumber;
  String date = '';
  String? error;
  bool empty = false;
  List<NotificationModel> models = [];

  NotificationModel(
      {required this.orderNumber,
      required this.title,
      required this.body,
      required this.date});

  NotificationModel.Empty() {
    this.empty = true;
  }
  NotificationModel.Error(this.error);

  NotificationModel.Data(MyNotificationResponse orders) {
    var data = orders.data;
    data?.forEach((element) {
      String notificationDate = DateFormat.jm().format(DateHelper.convert(
        element.createdAt?.timestamp)) +
          '   ' +
          DateFormat.yMd().format(
              DateHelper.convert(element.createdAt?.timestamp));
      models.add(NotificationModel(
          title: element.title ?? '',
          orderNumber: element.orderNumber.toString(),
          body: element.message ?? '',
          date: notificationDate));
    });
  }
  bool get hasError => error != null;

  bool get isEmpty => empty;

  List<NotificationModel> get data {
    return models;
  }
}

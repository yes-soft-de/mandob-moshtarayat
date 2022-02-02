import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_my_notifications/notification_model.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/widget/my_notifications/my_notifications_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';

import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';
import 'my_notifications_state.dart';

class MyNotificationsLoadedState extends MyNotificationsState {
  MyNotificationsScreenState screenState;
  List<NotificationModel> model;
  MyNotificationsLoadedState(this.screenState, this.model) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: RefreshIndicator(
        onRefresh: () {
          return screenState.getNotifications();
        },
        child: ListView(
          physics:
          BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
//            MyNotificationsAppBar(),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10,
              ),
              child: ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.sortAmountDown,
                  color: Theme.of(context).primaryColor,
                  size: 18,
                ),
                title: Text(
                  S.of(context).sortByEarlier,
                  style: StyleText.categoryStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: getNotification(context)),
            ),
            SizedBox(
              height: 75,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getNotification(BuildContext context) {
    List<Widget> children = [];
    model.forEach((element) {
      children.add(Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).backgroundColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            ),
          ),
          title: Text(element.title),
          subtitle: Text(element.body),
          trailing: Container(
              height: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Text(element.date),
              )),
        ),
      ));
    });
    return children;
  }
}

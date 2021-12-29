import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'my_notifications_state.dart';

class MyNotificationsLoadingState extends MyNotificationsState {
  MyNotificationsLoadingState(MyNotificationsScreenState screenState)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

import 'package:flutter/material.dart';

class MyNotificationsAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
            child: Image.asset(
          'assets/images/notifications.png',
          width: 220,
        )),
      ],
    );
  }
}

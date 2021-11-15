import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';

class CustomListTileCaptainsPayment extends StatelessWidget {
  final String title;
  String subTitle;
  final IconData iconData;

  CustomListTileCaptainsPayment(
      {required this.title, required this.subTitle, required this.iconData});

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    if (title == S.current.captainStatus || title == S.current.status) {
      icon = PhysicalModel(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 5,
          shape: BoxShape.circle,
          child: Icon(
            Icons.circle,
            color: subTitle == 'active' ? Colors.green : Colors.red,
            size: 30,
          ));
      subTitle = subTitle == 'active'
          ? S.current.captainStateActive
          : S.current.captainStateInactive;
    }
    return ListTile(
      leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(iconData, color: Theme.of(context).disabledColor),
          )),
      title: Text(
        title,
        style: TextStyle(),
      ),
      trailing: icon,
      subtitle: Text(
        subTitle,
        style: TextStyle(),
        textDirection: S.current.phoneNumber == title &&
                Localizations.localeOf(context).languageCode == 'ar'
            ? TextDirection.ltr
            : null,
        textAlign: S.current.phoneNumber == title &&
                Localizations.localeOf(context).languageCode == 'ar'
            ? TextAlign.right
            : null,
      ),
    );
  }
}

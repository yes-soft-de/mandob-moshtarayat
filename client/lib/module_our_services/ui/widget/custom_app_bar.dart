import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';

class CustomAppBar {
  static PreferredSizeWidget sendItBar(BuildContext context,
      {required title, required GestureTapCallback onTap}) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).brightness != Brightness.dark
                      ? Theme.of(context).disabledColor
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      elevation: 0,
    );
  }
}

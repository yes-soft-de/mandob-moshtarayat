import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';

class CustomTwaslnaAppBar {
  static PreferredSizeWidget appBar(BuildContext context,
      {required title,
      GestureTapCallback? onTap,
      Color? colorIcon,
      Color? buttonBackground}) {
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
            onTap: onTap ?? () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                color: buttonBackground ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: colorIcon ?? Colors.white,
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

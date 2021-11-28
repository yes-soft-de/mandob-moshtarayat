import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';

class CustomTwaslnaAppBar {
  static PreferredSizeWidget appBar(
    BuildContext context, {
    required title,
    GestureTapCallback? onTap,
    Color? colorIcon,
    Color? buttonBackground,
    IconData? icon,
    bool canGoBack = true,
  }) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
      ),
      leading: canGoBack
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: onTap ?? () => Navigator.of(context).pop(),
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            buttonBackground ?? Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        icon ?? Icons.arrow_back,
                        color: colorIcon ?? Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Container(),
      elevation: 0,
    );
  }
}

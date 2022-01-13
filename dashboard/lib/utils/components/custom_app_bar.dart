import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/utils/global/screen_type.dart';

class CustomMandoobAppBar {
  static PreferredSizeWidget appBar(BuildContext context,
      {required title,
      GestureTapCallback? onTap,
      Color? colorIcon,
      Color? buttonBackground,
      IconData? icon,
      bool canGoBack = true,
      List<Widget>? actions}) {
    if (icon == Icons.menu && ScreenType.isDesktop(context)) {
      icon = null;
      onTap = null;
      canGoBack = false;
    }
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(title),
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
      actions: actions,
    );
  }
}

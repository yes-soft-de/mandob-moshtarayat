import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/utils/global/screen_type.dart';

class CustomTwaslnaAppBar {
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
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(16),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 24.0, left: 24.0, bottom: 8.0),
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                width: double.maxFinite,
              ),
            )),
      ),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 16.0, left: 16.0, top: 10.0, bottom: 10.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
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
      actions: actions,
    );
  }
}

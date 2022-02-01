import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

import 'my_notifications_state.dart';

class MyNotificationsErrorState extends MyNotificationsState {
  final String error;
  MyNotificationsScreenState screenState;

  MyNotificationsErrorState(this.screenState, this.error) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.current.notifications,
          background: Theme.of(context).cardColor,
          colorIcon: Colors.red),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flushbar(
                  title: S.of(context).thisErrorHappened,
                  message: error,
                  icon: Icon(
                    Icons.info,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  flushbarStyle: FlushbarStyle.FLOATING,
                ),
              ),
              Container(
                height: 24,
              ),
              SvgPicture.asset(
                ImageAsset.ERROR_SVG,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Container(
                height: 32,
              ),
              Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0),
                      onPressed: () async {
                        await screenState.getNotifications();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).refresh,
                          style: TextStyle(color: Colors.white),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

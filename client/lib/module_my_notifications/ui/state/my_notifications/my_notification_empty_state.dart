import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'my_notifications_state.dart';

class MyNotificationsEmptyState extends MyNotificationsState {
  final String empty;
  MyNotificationsScreenState screenState;

  MyNotificationsEmptyState(this.screenState, this.empty) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
       appBar: CustomTwaslnaAppBar.appBar(context, title: S.current.notifications,background: Theme.of(context).cardColor),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              height: 75,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  empty,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
            ),
            SvgPicture.asset(
              ImageAsset.EMPTY_SVG,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
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
    );
  }
}

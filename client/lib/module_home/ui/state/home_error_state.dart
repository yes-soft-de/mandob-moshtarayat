import 'dart:collection';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class HomeErrorState extends HomeState {
  final List<String> errors;
  HomeScreenState screenState;

  HomeErrorState(this.screenState, this.errors) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    List<String> errs = LinkedHashSet<String>.from(errors).toList();
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flushbar(
                title: (errs.length > 1
                        ? S.of(context).errOc
                        : S.of(context).thisErrorHappened) +
                    ' : ',
                messageText: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: getErrorMessage(errs, errs.length > 1)),
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
            SvgPicture.asset(
              ImageAsset.ERROR_SVG,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0),
                    onPressed: () async {
                      await screenState.getHomeData();
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

  List<Widget> getErrorMessage(List<String> errs, bool indexed) {
    List<Widget> errorMessages = [];
    int i = 1;
    String index;
    errs.forEach((element) {
      index = indexed ? '$i- ' : '';
      errorMessages.add(Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          index + element,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ));
      i++;
    });
    return errorMessages;
  }
}

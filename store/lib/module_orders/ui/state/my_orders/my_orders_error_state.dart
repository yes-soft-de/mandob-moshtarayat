import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';


class MyOrdersErrorState extends States {
  final String error;
  State<StatefulWidget> screenState;
  final Function() refresh;
  MyOrdersErrorState(this.screenState, this.error,{required this.refresh}) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
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
                title:S.of(context).thisErrorHappened,
                message:error,
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
            Container(height: 24,),
            SvgPicture.asset(
              SvgAsset.ERROR_SVG,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Container(height: 32,),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0),
                    onPressed: () async {
                    refresh();
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

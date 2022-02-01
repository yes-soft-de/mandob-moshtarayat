import 'package:flutter_svg/svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loading_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class HomeEmptyState extends HomeState {
  final String empty;
  HomeScreenState screenState;

  HomeEmptyState(this.screenState, this.empty) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
}

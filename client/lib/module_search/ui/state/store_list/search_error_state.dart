import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_search/ui/screen/search_screen.dart';
import 'package:mandob_moshtarayat/module_search/ui/state/store_list/search_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_list_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_list/store_list_state.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class SearchErrorState extends SearchState {
  final String error;
  SearchScreenState screenState;
  SearchErrorState(this.screenState, this.error) : super(screenState);

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
          ],
        ),
      ),
    );
  }
}

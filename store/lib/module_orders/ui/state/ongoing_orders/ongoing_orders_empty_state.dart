import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/OngoingOrdersScreen.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

import 'ongoing_orders_state.dart';


class OnGoingOrdersEmptyState extends OngoingState {
  final String empty;
  OnGoingOrdersScreenState screenState;
  final Function() refresh;
  OnGoingOrdersEmptyState(this.screenState, this.empty,{required this.refresh}) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(height: 75,),
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
            SvgAsset.EMPTY_SVG,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
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
    );
  }
}

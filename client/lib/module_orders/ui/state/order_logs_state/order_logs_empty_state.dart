import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_logs_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_logs_state/order_logs_state.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class OrderLogsEmptyState extends OrderLogsState {
  final String empty;
  OrderLogsScreenState screenState;

  OrderLogsEmptyState(this.screenState, this.empty) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
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
                    await screenState.getOrders();
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

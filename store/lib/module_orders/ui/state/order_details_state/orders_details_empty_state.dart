import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_details_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_details_state/order_details_state.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class OrderDetailsEmptyState extends OrderDetailsState {
  final String empty;
  final int id;
  OrderDetailsScreenState screenState;

  OrderDetailsEmptyState(this.screenState, this.empty, this.id)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              height: 50,
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
                      screenState.getOrderDetails(id);
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

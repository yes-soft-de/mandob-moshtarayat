import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_status_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_status/order_status_state.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class OrderStatusErrorState extends OrderStatusState {
  final String error;
  final int id;
  OrderStatusScreenState screenState;

  OrderStatusErrorState(this.screenState, this.error, this.id)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).orderStatus, buttonBackground: Colors.red),
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
                        screenState.getOrderStatus(id);
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

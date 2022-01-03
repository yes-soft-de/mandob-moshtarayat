import 'package:mandob_moshtarayat/consts/order_status.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_details_model.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_status_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/order_status/custom_step.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_status/order_status_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/order_status/custom_order_status_app_bar.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/utils/helpers/order_status_helper.dart';

class OrderStatusLoadedState extends OrderStatusState {
  OrderStatusScreenState screenState;
  OrderDetailsModel orderDetails;
  OrderStatusLoadedState(this.screenState, this.orderDetails)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          color: Theme.of(context).primaryColor,
        ),
        CustomOrderStatusAppBar(
          hide: orderDetails.order.state == OrderStatus.WAITING,
          onRate: (rate) {
            screenState.rateCaptain(RateCaptainRequest(
                rating: rate,
                itemType: 'captain',
                itemID: orderDetails.order.captainID,
                orderNumber: screenState.orderNumber));
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height * 0.88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              color: Theme.of(context).cardColor,
            ),
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.all(8),
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text(S.of(context).orderStatusDescription),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                      child: Divider(
                        color: Theme.of(context).backgroundColor,
                        thickness: 2.5,
                      ),
                    ),
                    Flex(
                      direction: Axis.vertical,
                      children: getStepper(StatusHelper.getOrderStatusIndex(
                          orderDetails.order.state)),
                    ),
                    SizedBox(
                      height: 75,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> getStepper(int currentIndex) {
    List<Widget> steps = [
      CustomStep(status: OrderStatus.WAITING, currentIndex: currentIndex),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: Theme.of(screenState.context).primaryColor.withOpacity(0.7),
          ),
        ),
      ),
      CustomStep(status: OrderStatus.GOT_CAPTAIN, currentIndex: currentIndex),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: currentIndex <
                    StatusHelper.getOrderStatusIndex(OrderStatus.GOT_CAPTAIN)
                ? Theme.of(screenState.context).disabledColor
                : Theme.of(screenState.context).primaryColor,
          ),
        ),
      ),
      CustomStep(status: OrderStatus.IN_STORE, currentIndex: currentIndex),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: currentIndex <
                    StatusHelper.getOrderStatusIndex(OrderStatus.IN_STORE)
                ? Theme.of(screenState.context).disabledColor
                : Theme.of(screenState.context).primaryColor,
          ),
        ),
      ),
      CustomStep(status: OrderStatus.DELIVERING, currentIndex: currentIndex),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: currentIndex <
                    StatusHelper.getOrderStatusIndex(OrderStatus.DELIVERING)
                ? Theme.of(screenState.context).disabledColor
                : Theme.of(screenState.context).primaryColor,
          ),
        ),
      ),
      CustomStep(status: OrderStatus.FINISHED, currentIndex: currentIndex),
    ];
    return steps;
  }
}

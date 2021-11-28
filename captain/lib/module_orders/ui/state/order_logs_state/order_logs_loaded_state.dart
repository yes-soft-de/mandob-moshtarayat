import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/order_logs.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/screens/order_logs_screen.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/order_logs_state/order_logs_state.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/widgets/order_log/log_card.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/translating.dart';
import 'package:mandob_moshtarayat_captain/utils/images/images.dart';
import 'package:mandob_moshtarayat_captain/utils/text_style/text_style.dart';

class OrderLogsLoadedState extends OrderLogsState {
  OrderLogsScreenState screenState;
  List<OrderLogsModel> orders;
  OrderLogsLoadedState(this.screenState, this.orders) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  ImageAsset.DELIVERY_MOTOR,
                  fit: BoxFit.cover,
                  height: 525,
                  width: 2500,
                  alignment: Alignment.bottomRight,
                ))),
        Container(
          color: Theme.of(context).cardColor.withOpacity(0.90),
          child: RefreshIndicator(
            onRefresh: () {
              return screenState.getOrders();
            },
            child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                    left: 10,
                  ),
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.sortAmountDown,
                      color: Theme.of(context).primaryColor,
                      size: 18,
                    ),
                    title: Text(
                      S.of(context).sortByEarlier,
                      style: StyleText.categoryStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: getOrders(orders),
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> getOrders(List<OrderLogsModel> orders) {
    if (orders.isEmpty) return [];
    List<OrderLogsCard> ordersCard = [];
    orders.forEach((element) {
      ordersCard.add(OrderLogsCard(
        orderId: element.orderNumber,
        orderStatus: element.state,
        orderDate: element.orderDate,
        completeTime: Trans.localString(
            element.completeTime.toString(), screenState.context),
      ));
    });
    return ordersCard;
  }
}

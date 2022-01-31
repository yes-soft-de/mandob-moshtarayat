import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_model.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/my_orders_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/my_orders/my_orders_state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/my_orders/my_orders_app_bar.dart';
import 'package:mandob_moshtarayat/module_orders/ui/widget/my_orders/order_card.dart';
import 'package:mandob_moshtarayat/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

class MyOrdersLoadedState extends MyOrdersState {
  MyOrdersScreenState screenState;
  List<OrderModel> orders;
  MyOrdersLoadedState(this.screenState, this.orders) : super(screenState);

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
                MyOrdersAppBar(),
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

  List<Widget> getOrders(List<OrderModel> orders) {
    if (orders.isEmpty) return [];
    List<OrderCard> ordersCard = [];
    orders.forEach((element) {
      ordersCard.add(OrderCard(
        orderId: element.orderId,
        orderCost: element.orderCost.toStringAsFixed(2),
        orderStatus: element.orderStatus,
        orderDate: element.orderDate,
      ));
    });
    return ordersCard;
  }
}

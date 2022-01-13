import 'package:intl/intl.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/model/order_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/screen/OngoingOrdersScreen.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/screen/orders_without_pending_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/widget/my_orders/order_card.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';

class OrderWithoutPendingLoadedState extends States {
  OrdersWithoutPendingScreenState screenState;
  List<OrderModel> orders;

  OrderWithoutPendingLoadedState(this.screenState, this.orders)
      : super(screenState) {
    if (screenState.fDate != null && screenState.lDate != null) {
      firstDate = screenState.fDate;
      lastDate = screenState.lDate;
    }
  }

  DateTime? firstDate;
  DateTime? lastDate;

  @override
  Widget getUI(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return screenState.getOrders();
      },
      child: FixedContainer(
          child: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
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
      )),
    );
  }

  List<Widget> getOrders(List<OrderModel> orders) {
    if (orders.isEmpty) return [];
    List<Widget> ordersCard = [];
    ordersCard.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(screenState.context).backgroundColor,
              ),
              child: ListTile(
                onTap: () {
                  showDatePicker(
                          context: screenState.context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime.now())
                      .then((value) {
                    if (value != null) {
                      firstDate = value;
                      screenState.refresh();
                    }
                  });
                },
                title: Text(S.current.firstDate),
                subtitle: Text(firstDate != null
                    ? DateFormat('yyyy/M/d').format(firstDate!)
                    : '0000/00/00'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 32,
              height: 2.5,
              color: Theme.of(screenState.context).backgroundColor,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(screenState.context).backgroundColor,
              ),
              child: ListTile(
                onTap: () {
                  showDatePicker(
                          context: screenState.context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime.now())
                      .then((value) {
                    if (value != null) {
                      lastDate = value;
                      screenState.refresh();
                    }
                  });
                },
                title: Text(S.current.lastDate),
                subtitle: Text(lastDate != null
                    ? DateFormat('yyyy/M/dd').format(lastDate!)
                    : '0000/00/00'),
              ),
            ),
          ),
        ],
      ),
    ));
    ordersCard.add(Padding(
      padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16, top: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            )),
        onPressed: firstDate != null && lastDate != null
            ? () => screenState.getOrderFilteredDate(firstDate!, lastDate!)
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            S.current.search,
            style: TextStyle(
                color: firstDate != null && lastDate != null
                    ? Colors.white
                    : null),
          ),
        ),
      ),
    ));
    ordersCard.add(Padding(
      padding: EdgeInsets.only(left: 36.0, right: 36.0),
      child: Divider(
        color: Theme.of(screenState.context).disabledColor.withOpacity(0.1),
        thickness: 2.0,
      ),
    ));

    orders.forEach((element) {
      ordersCard.add(OrderCard(
        onTap: () {
          Navigator.of(screenState.context).pushNamed(
              OrdersRoutes.ORDER_TIME_LINE,
              arguments: element.orderId);
        },
        orderId: element.orderId,
        orderCost: element.orderCost.toStringAsFixed(1),
        orderStatus: element.orderStatus,
        orderDate: DateFormat.jm().format(element.dateTime) +
            '   ' +
            DateFormat.yMd().format(element.dateTime),
      ));
    });
    return ordersCard;
  }
}

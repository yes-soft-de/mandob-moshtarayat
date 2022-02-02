import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/model/captain_logs_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/ui/screen/captain_logs_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/ui/screen/store_logs_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/ui/widget/chart_order_logs.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/ui/widget/logs_card.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/widget/my_orders/order_card.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';

class StoreLogsLoadedState extends States {
  final StoreLogsScreenState screenState;
  final List<String>? error;
  final bool empty;
  final CaptainLogsModel? captainBalance;

  StoreLogsLoadedState(this.screenState, this.captainBalance,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }

  int currentIndex = 0;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getCaptain();
        },
        errors: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCaptain();
          });
    }
    return FixedContainer(
        child: ListView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: getOrders(captainBalance?.data),
          ),
        ),
        SizedBox(
          height: 75,
        ),
      ],
    ));
  }

  List<Widget> getOrders(List<CaptainLogsModel>? orders) {
    if (orders == null) return [];
    if (orders.isEmpty) return [];
    List<Widget> ordersCard = [];
    orders.forEach((element) {
      ordersCard.add(LogCard(
        deliverPrice: element.deliveryCost.toString(),
        orderType: element.orderType == 1
            ? S.current.products
            : element.orderType == 2
                ? S.current.privateOrder
                : S.current.deliverForMe,
        orderId: element.orderNumber,
        orderCost: element.orderCost.toString(),
        orderStatus: element.state,
        orderDate: DateFormat.jm().format(element.deliveryDate) +
            '   ' +
            DateFormat.yMd().format(element.deliveryDate),
      ));
    });
    ordersCard.insert(
        0,
        FixedContainer(
          child: PieChartSample2(
            countDeliver: captainBalance!.countSendOnMeOrder,
            countPrivate: captainBalance!.countPrivateOrder,
            countProducts: captainBalance!.countProductOrder,
          ),
        ));
    return ordersCard;
  }
}

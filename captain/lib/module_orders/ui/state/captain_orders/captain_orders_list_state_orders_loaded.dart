import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/accept_order.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/order_model.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/widgets/home_widgets/order_card.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_captain/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_captain/utils/components/error_screen.dart';
import 'captain_orders_list_state.dart';
import 'package:timeago/timeago.dart' as timeago;

class CaptainOrdersListStateOrdersLoaded extends CaptainOrdersListState {
  final AcceptOrderModel myOrders;
  final OrderModel nearbyOrders;

  CaptainOrdersListStateOrdersLoaded(
      CaptainOrdersScreenState screenState, this.myOrders, this.nearbyOrders)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).home, icon: Icons.sort_rounded, onTap: () {
        screenState.advancedController.showDrawer();
      }),
      body: Stack(
        children: [
          PageView(
            controller: screenState.ordersPageController,
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            onPageChanged: (pos) {
              screenState.currentPage = pos;
              screenState.refresh();
            },
            children: [
              getMyOrdersList(context),
              getNearbyOrdersList(context),
            ],
          ),
          Align(alignment: Alignment.bottomCenter, child: _Footer(context))
        ],
      ),
    );
  }

  Widget _Footer(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.pinned,
      snakeShape: SnakeShape.indicator,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      snakeViewColor: Theme.of(context).primaryColor,
      selectedItemColor: SnakeShape.indicator == SnakeShape.indicator
          ? Theme.of(context).primaryColor
          : null,
      unselectedItemColor: Theme.of(context).disabledColor,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: screenState.currentPage,
      onTap: (index) {
        screenState.currentPage = index;
        screenState.ordersPageController.animateToPage(screenState.currentPage,
            duration: Duration(milliseconds: 750), curve: Curves.linear);
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: '${S.of(context).currentOrders}'),
        BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: '${S.of(context).nearbyOrders}'),
      ],
    );
  }

  Widget getMyOrdersList(BuildContext context) {
    var uiList = <Widget>[];
    if (myOrders.hasError) {
      return ErrorStateWidget(
        error: myOrders.error,
        onRefresh: () {
          screenState.getMyOrders();
        },
      );
    } else if (myOrders.empty) {
      return EmptyStateWidget(
        empty: S.current.homeDataEmpty,
        onRefresh: () {
          screenState.getMyOrders();
        },
      );
    } else {
      myOrders.data.forEach((element) {
        uiList.add(OrderCard(
          orderId: element.orderNumber,
          orderStatus: element.state,
          orderDate: timeago.format(element.deliveryDate,
              locale: Localizations.localeOf(context).languageCode),
          orderType: element.orderType,
          acceptedOrder: true,
        ));
      });
      uiList.add(Container(
        height: 75,
      ));
      return RefreshIndicator(
          child: CustomListView.custom(children: uiList),
          onRefresh: () {
            return screenState.refreshOrders();
          });
    }
  }

  Widget getNearbyOrdersList(BuildContext context) {
    if (nearbyOrders.hasError) {
      return ErrorStateWidget(
        error: nearbyOrders.error,
        onRefresh: () {
          screenState.getMyOrders();
        },
      );
    }
    if (nearbyOrders.empty) {
      return EmptyStateWidget(
        empty: S.current.homeDataEmpty,
        onRefresh: () {
          screenState.getMyOrders();
        },
      );
    }
    List<OrderModel> orders =
        sortLocations(nearbyOrders.data, nearbyOrders.currentLocation);
    var now = DateTime.now();
    var moment = Moment.now();
    var uiList = <Widget>[];
    orders.forEach((element) {
      var orderDate = now.isBefore(element.deliveryDate)
          ? moment.from(element.deliveryDate)
          : timeago.format(element.deliveryDate);
      uiList.add(OrderCard(
        orderId: element.orderNumber,
        orderDestination: element.storeDistance,
        orderDate: orderDate.toString(),
        orderType: element.orderType,
        storeName: element.storeName,
        branchName: element.branchName,
      ));
    });
    uiList.add(Container(
      height: 75,
    ));
    return RefreshIndicator(
        child: CustomListView.custom(children: uiList),
        onRefresh: () {
          return screenState.refreshOrders();
        });
  }

  List<OrderModel> sortLocations(List<OrderModel> order, var currentLocation) {
    if (currentLocation == null) {
      return order;
    }
    var sorted = order;
    sorted.sort((a, b) {
      try {
        double first = a.storeDistance ?? 0;
        double second = b.storeDistance ?? 0;
        return first.compareTo(second);
      } catch (e) {
        print(e.toString());
        return 1;
      }
    });
    return sorted;
  }
}

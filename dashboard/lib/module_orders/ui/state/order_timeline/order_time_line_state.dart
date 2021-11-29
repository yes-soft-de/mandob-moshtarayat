import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/consts/order_status.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/model/order_time_line_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/screen/order_timeline_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/widget/custom_step.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/order_status_helper.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/translating.dart';

class OrderTimLineLoadedState extends States {
  OrderTimLineScreenState screenState;
  String? error;
  bool empty;
  OrderTimeLineModel? model;
  OrderTimLineLoadedState(this.screenState, this.model,
      {this.error, this.empty = false})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getOrder();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getOrder();
          });
    }
    return FixedContainer(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(8),
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25))),
                leading: Container(
                    height: double.maxFinite,
                    width: 50,
                    child: Icon(
                      FontAwesomeIcons.solidClock,
                      color: Colors.white,
                    )),
                tileColor: Theme.of(context).primaryColor,
                title: Text(
                  S.current.deliveryTime,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text(
                  Trans.localString(
                      model?.orderStatus.deliveredTime ?? '', context),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(25))),
                leading: Container(
                    height: double.maxFinite,
                    width: 50,
                    child: Icon(
                      FontAwesomeIcons.delicious,
                      color: Colors.white,
                    )),
                tileColor: Theme.of(context).primaryColor,
                title: Text(
                  S.current.orderTime,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text(
                  Trans.localString(
                      model?.orderStatus.completionTime ?? '', context),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Flex(
                direction: Axis.vertical,
                children: getStepper(StatusHelper.getOrderStatusIndex(
                    model?.orderStatus.currentStage ??
                        OrderStatusEnum.WAITING)),
              ),
              SizedBox(
                height: 75,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> getStepper(int currentIndex) {
    List<Widget> steps = [
      CustomStep(
          status: OrderStatusEnum.WAITING,
          currentIndex: currentIndex,
          date: model!.logs.isNotEmpty
              ? DateFormat(' yyyy/M/dd ')
                  .add_jm()
                  .format(model?.logs[0].createdAt ?? DateTime.now())
              : null),
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
      CustomStep(
          status: OrderStatusEnum.GOT_CAPTAIN,
          currentIndex: currentIndex,
          date: model!.logs.length >= 2
              ? DateFormat(' yyyy/M/dd ')
                  .add_jm()
                  .format(model?.logs[1].createdAt ?? DateTime.now())
              : null),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: currentIndex <
                    StatusHelper.getOrderStatusIndex(
                        OrderStatusEnum.GOT_CAPTAIN)
                ? Theme.of(screenState.context).disabledColor
                : Theme.of(screenState.context).primaryColor,
          ),
        ),
      ),
      CustomStep(
          status: OrderStatusEnum.IN_STORE,
          currentIndex: currentIndex,
          date: model!.logs.length >= 3
              ? DateFormat(' yyyy/M/dd ')
                  .add_jm()
                  .format(model?.logs[1].createdAt ?? DateTime.now())
              : null),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: currentIndex <
                    StatusHelper.getOrderStatusIndex(OrderStatusEnum.IN_STORE)
                ? Theme.of(screenState.context).disabledColor
                : Theme.of(screenState.context).primaryColor,
          ),
        ),
      ),
      CustomStep(
          status: OrderStatusEnum.DELIVERING,
          currentIndex: currentIndex,
          date: model!.logs.length >= 4
              ? DateFormat(' yyyy/M/dd ')
                  .add_jm()
                  .format(model?.logs[1].createdAt ?? DateTime.now())
              : null),
      Padding(
        padding: const EdgeInsets.only(right: 22.0, left: 22.0),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 2.5,
            color: currentIndex <
                    StatusHelper.getOrderStatusIndex(OrderStatusEnum.DELIVERING)
                ? Theme.of(screenState.context).disabledColor
                : Theme.of(screenState.context).primaryColor,
          ),
        ),
      ),
      CustomStep(
          status: OrderStatusEnum.FINISHED,
          currentIndex: currentIndex,
          date: model!.logs.length >= 4
              ? DateFormat(' yyyy/M/dd ')
                  .add_jm()
                  .format(model?.logs[1].createdAt ?? DateTime.now())
              : null),
    ];
    return steps;
  }
}

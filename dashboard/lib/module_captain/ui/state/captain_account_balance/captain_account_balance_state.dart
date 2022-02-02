import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captain_balance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/widget/custom_tile.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/scaling.dart';

class CaptainBalanceLoadedState extends States {
  final CaptainBalanceScreenState screenState;
  final List<String>? error;
  final bool empty;
  final AccountBalance? captainBalance;
  final AccountBalance? captainBalanceLastMonth;
  final AccountBalance? specificCaptainBalance;

  CaptainBalanceLoadedState(
      this.screenState, this.captainBalance, this.captainBalanceLastMonth,
      {this.empty = false, this.error, this.specificCaptainBalance})
      : super(screenState) {
    currentIndex = screenState.currentIndex;
    if (error != null) {
      screenState.refresh();
    }
    if (screenState.fDate != null && screenState.lDate != null) {
      firstDate = screenState.fDate;
      lastDate = screenState.lDate;
    }
  }

  int currentIndex = 0;
  DateTime? firstDate;
  DateTime? lastDate;
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
        child: Flex(
      direction: Axis.vertical,
      children: [
        Hider(
            active: captainBalance != null && captainBalanceLastMonth != null,
            child: _Footer(context)),
        Expanded(
          child: CustomListView.custom(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Hider(
                          active: currentIndex != 2,
                          child: ListTile(
                            leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(screenState.context)
                                      .primaryColor,
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.info_rounded,
                                  color: Colors.white,
                                ))),
                            title: Text(S.current.myBalanceHint),
                          ),
                        ),
                        Hider(
                          active: currentIndex == 2,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Theme.of(screenState.context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              showDatePicker(
                                                      context:
                                                          screenState.context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2021),
                                                      lastDate: DateTime.now())
                                                  .then((value) {
                                                if (value != null) {
                                                  firstDate = value;
                                                  screenState.refresh();
                                                }
                                              });
                                            },
                                            title: Center(
                                                child:
                                                    Text(S.current.firstDate)),
                                            subtitle: Center(
                                                child: Text(firstDate != null
                                                    ? DateFormat('yyyy/M/d')
                                                        .format(firstDate!)
                                                    : '0000/00/00')),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 32,
                                          height: 2.5,
                                          color: Theme.of(screenState.context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Theme.of(screenState.context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              showDatePicker(
                                                      context:
                                                          screenState.context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2021),
                                                      lastDate: DateTime.now())
                                                  .then((value) {
                                                if (value != null) {
                                                  lastDate = value;
                                                  screenState.refresh();
                                                }
                                              });
                                            },
                                            title: Center(
                                                child:
                                                    Text(S.current.lastDate)),
                                            subtitle: Center(
                                                child: Text(lastDate != null
                                                    ? DateFormat('yyyy/M/dd')
                                                        .format(lastDate!)
                                                    : '0000/00/00')),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18.0,
                                    right: 18.0,
                                    bottom: 16,
                                    top: 16),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      )),
                                  onPressed: firstDate != null &&
                                          lastDate != null
                                      ? () =>
                                          screenState.getBalanceFilteredDate(
                                              firstDate!,
                                              lastDate!,
                                              captainBalance,
                                              captainBalanceLastMonth)
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      S.current.search,
                                      style: TextStyle(
                                          color: firstDate != null &&
                                                  lastDate != null
                                              ? Colors.white
                                              : null),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 16),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        data(context)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget data(BuildContext context) {
    if (captainBalanceLastMonth != null && captainBalance != null) {
      return Flex(
        direction: Axis.vertical,
        children: [
          currentIndex == 0
              ? balanceDetails(context, captainBalance ?? AccountBalance.none())
              : SizedBox(),
          currentIndex == 1
              ? balanceDetails(
                  context, captainBalanceLastMonth ?? AccountBalance.none())
              : SizedBox(),
          Hider(
            active: currentIndex == 2 && specificCaptainBalance != null,
            child: balanceDetails(
                context, specificCaptainBalance ?? AccountBalance.none()),
          )
        ],
      );
    }
    return balanceDetails(context,
        captainBalance ?? captainBalanceLastMonth ?? AccountBalance.none());
  }

  Widget _Footer(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.rectangle,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      snakeViewColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Theme.of(context).disabledColor,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: currentIndex,
      padding: EdgeInsets.all(8),
      onTap: (index) {
        currentIndex = index;
        screenState.currentIndex = currentIndex;
        screenState.refresh();
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.system_update_tv_rounded),
            label: '${S.of(context).actual}'),
        BottomNavigationBarItem(
            icon: Icon(Icons.update_rounded),
            label: '${S.of(context).lastMonth}'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: '${S.of(context).specific}'),
      ],
    );
  }

  Widget balanceDetails(BuildContext context, AccountBalance balance) {
    return Flex(
      direction: Axis.vertical,
      children: [
        CustomTile(Icons.local_atm_rounded, S.current.sumPaymentsFromCaptain,
            balance.sumPaymentsFromCaptain),
        CustomTile(Icons.account_balance_rounded,
            S.current.sumPaymentsToCaptain, balance.sumPaymentsToCaptain),
        CustomTile(Icons.delivery_dining_rounded,
            S.current.countOrdersDelivered, balance.countOrdersDelivered),
        CustomTile(Icons.account_balance_wallet_rounded, S.current.amountYouOwn,
            balance.amountYouOwn),
        CustomTile(
            Icons.monetization_on_rounded,
            S.current.remainingAmountForCompany,
            balance.remainingAmountForCompany),
        CustomTile(FontAwesomeIcons.gift, S.current.bounce, balance.bounce),
        CustomTile(
            Icons.add_road, S.current.kilometerBonus, balance.kilometerBonus),
        CustomTile(Icons.show_chart, S.current.netProfit, balance.netProfit),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16),
          child: Divider(
            thickness: 2,
          ),
        ),
        CustomTile(FontAwesomeIcons.coins, S.current.total, balance.total),
      ],
    );
  }
}

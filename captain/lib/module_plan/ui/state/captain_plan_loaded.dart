import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_plan/model/captain_balance_model.dart';
import 'package:mandob_moshtarayat_captain/module_plan/ui/screen/plan_screen.dart';
import 'package:mandob_moshtarayat_captain/module_plan/ui/state/plan_state.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_captain/utils/effect/scaling.dart';

class CaptainPlanScreenStateLoaded extends PlanState {
  AccountBalance? captainBalance;
  AccountBalance? captainBalanceLastMonth;
  final PlanScreenState screenState;
  CaptainPlanScreenStateLoaded(
      this.screenState, this.captainBalance, this.captainBalanceLastMonth)
      : super(screenState);
  int currentIndex = 0;
  @override
  Widget getUI(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        _Footer(context),
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
                        ListTile(
                          leading: Icon(Icons.info_rounded),
                          title: Text(S.current.myBalanceHint),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 16),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        currentIndex == 0
                            ? balanceDetails(context,
                                captainBalance ?? AccountBalance.none())
                            : SizedBox(),
                        currentIndex == 1
                            ? balanceDetails(
                                context,
                                captainBalanceLastMonth ??
                                    AccountBalance.none())
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
        screenState.refresh();
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.system_update_tv_rounded),
            label: '${S.of(context).actual}'),
        BottomNavigationBarItem(
            icon: Icon(Icons.update_rounded),
            label: '${S.of(context).lastMonth}'),
      ],
    );
  }

  Widget CustomTile(IconData icon, String text, num value) {
    bool currency = S.current.countOrdersDelivered != text;
    return ScalingWidget(
      milliseconds: 1250,
      fade: true,
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        trailing: Container(
          constraints:
              BoxConstraints(maxWidth: 120, minWidth: 95, maxHeight: 55),
          decoration: BoxDecoration(
            color: Theme.of(screenState.context).disabledColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${value.toStringAsFixed(2)} ${currency ? S.current.sar : S.current.sOrder}',
              style: TextStyle(
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget balanceDetails(BuildContext context, AccountBalance balance) {
    return Flex(
      direction: Axis.vertical,
      children: [
        CustomTile(Icons.local_atm_rounded, S.current.sumPaymentsFromCompany,
            balance.sumPaymentsFromCompany),
        CustomTile(Icons.account_balance_rounded,
            S.current.sumPaymentsToCompany, balance.sumPaymentsToCompany),
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

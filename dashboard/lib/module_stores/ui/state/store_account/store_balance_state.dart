import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/widget/custom_list_tile.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/store_balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/store_balance_screen.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';
import 'package:intl/intl.dart' as intl;

class StoreBalanceLoadedState extends States {
  StoreBalanceLoadedState(this.screenState, this.model,
      {this.error, this.empty = false})
      : super(screenState);

  final bool empty;
  final String? error;
  final StoreBalanceModel? model;
  final StoreBalanceScreenState screenState;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getPayments();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getPayments();
          });
    }
    return FixedContainer(
      child: CustomListView.custom(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                CustomListTileCaptainsPayment(
                    title: S.of(context).remainingAmountForStore,
                    subTitle: model?.amountOwedToStore.toString() ?? '',
                    iconData: Icons.monetization_on_rounded),
                CustomListTileCaptainsPayment(
                    title: S.of(context).sumPaymentsForStore,
                    subTitle: model?.sumPaymentsToStore.toString() ?? '',
                    iconData: Icons.monetization_on_rounded),
                CustomListTileCaptainsPayment(
                    title: S.of(context).total,
                    subTitle: model?.total.toString() ?? '',
                    iconData: Icons.monetization_on_rounded),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32.0, left: 32),
            child: Divider(
              thickness: 2.5,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          getCaptainPaymentFrom(),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget getCaptainPaymentFrom() {
    List<Widget> widgets = [];
    widgets.add(
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            S.current.paymentsForStore,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
    model?.paymentsToStore.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(screenState.context).backgroundColor,
          ),
          child: ListTile(
            onTap: element.note != null
                ? () {
                    showDialog(
                        context: screenState.context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            title: Text(S.current.note),
                            content: Container(
                              child: Text(element.note ?? ''),
                            ),
                          );
                        });
                  }
                : null,
            leading: Icon(Icons.credit_card_rounded),
            title: Text(S.current.paymentAmount),
            subtitle: Text(element.amount.toString()),
            trailing:
                Text(intl.DateFormat('yyyy/M/dd').format(element.paymentDate)),
          ),
        ),
      ));
    });
    return Hider(
      active: model?.paymentsToStore.isNotEmpty == true,
      child: Column(
        children: widgets,
      ),
    );
  }
}

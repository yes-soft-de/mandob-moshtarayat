import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/widget/custom_list_tile.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/store_balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/request/store_payment_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/store_balance_screen.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
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
  final _amount = TextEditingController();
  final _note = TextEditingController();
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
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, bottom: 8, right: 12, top: 16.0),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                S.current.paymentAmount,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          CustomFormField(
            controller: _amount,
            hintText: S.current.paymentAmount,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, bottom: 8, right: 12, top: 16.0),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                S.current.note,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          CustomFormField(
            controller: _note,
            hintText: S.current.note,
            last: true,
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {
                screenState.pay(StorePaymentRequest(
                    storeOwnerProfileId: screenState.storeID,
                    note: _note.text,
                    amount: num.parse(_amount.text.trim())));
              },
              style: ElevatedButton.styleFrom(
                onSurface: Theme.of(context).primaryColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    S.current.pay,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
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

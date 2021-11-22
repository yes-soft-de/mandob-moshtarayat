import 'package:intl/intl.dart' as intl;
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/porfile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/screen/paymen_from_captain_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/widget/custom_list_tile.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';

class PaymentsForCaptainLoadedState extends States {
  final PaymentsFromCaptainScreenState screenState;
  final String? error;
  final bool empty;
  final ProfileModel? model;
  final BalanceModel? balanceModel;

  PaymentsForCaptainLoadedState(this.screenState, this.model, this.balanceModel,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
    accountBalance = balanceModel?.data;
  }

  final _amount = TextEditingController();
  final _note = TextEditingController();

  String? id;

  AccountBalance? accountBalance;

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
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Flex(
          direction: Axis.vertical,
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
              last: true,
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
                  screenState.pay(CaptainPaymentsRequest(
                      captainId: screenState.captainId,
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
            SizedBox(
              height: 16,
            ),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Text(
            //       S.current.captainInfo,
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).backgroundColor,
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   child: Column(
            //     children: [
            //       customListTile(
            //           title: S.of(context).name,
            //           subTitle: model?.name,
            //           iconData: Icons.person),
            //       customListTile(
            //           title: S.of(context).phone,
            //           subTitle: model?.phone,
            //           iconData: Icons.phone),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 32.0, left: 32),
            //   child: Divider(
            //     thickness: 2.5,
            //     color: Theme.of(context).backgroundColor,
            //   ),
            // ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  S.current.captainInfoBalance,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  // customListTile(
                  //     title: S.of(context).salary,
                  //     subTitle: accountBalance?.salary.toString(),
                  //     iconData: Icons.money),
                  CustomListTileCaptainsPayment(
                      title: S.of(context).remainingAmountForCompany,
                      subTitle: accountBalance?.remainingAmountForCompany
                              .toString() ??
                          '',
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
      ),
    ));
  }

  Widget getCaptainPaymentFrom() {
    List<Widget> widgets = [];
    widgets.add(
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            S.current.paymentsFromCaptain,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
    accountBalance?.paymentsFromCaptain.forEach((element) {
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
      active: accountBalance?.paymentsFromCaptain.isNotEmpty ?? false,
      child: Column(
        children: widgets,
      ),
    );
  }
}

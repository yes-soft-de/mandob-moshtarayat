import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_balance/model/balance_model.dart';
import 'package:mandob_moshtarayat/module_balance/ui/screen/balance_screen.dart';
import 'package:mandob_moshtarayat/module_stores/model/store_model.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/payment_method.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/components/stacked_form.dart';

class BalanceLoadedState extends States {
  BalanceScreenState screenState;
  BalanceModel? balanceModel;
  final String? error;
  final bool empty;

  BalanceLoadedState(this.screenState, this.balanceModel, {this.error, this.empty = false})
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
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
//          screenState.getStore(screenState.model?.id ?? -1);
        },
        error: error,
      );
    }
    return RefreshIndicator(
      onRefresh: () {
        return screenState.getOrders();
      },
      child:Stack(
         children: [
          FixedContainer(
           child: ListView(
             physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
             children: [
               Padding(
                 padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                 child: ListView(
                   shrinkWrap: true,
                   physics: ScrollPhysics(),
                   children: getProducts(),
                 ),
               ),
               SizedBox(
                 height: 75,
               ),
             ],
           )),
           Align(
               alignment: Alignment.bottomCenter,
               child: SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(children: [
                     Card(
                       color: Theme.of(context).primaryColor,
                       shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                       child: Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Row(
                         children: [
                           Text(S.current.remainingAmount +': '),
                           Text(balanceModel!.totalRemainingPaymentsToRepresentative.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                         ],
                       ),
                     ),),
                     Card(
                       color: Theme.of(context).primaryColor,
                       shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                       child: Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Row(
                         children: [
                           Text(S.current.totalDues +': '),
                           Text(balanceModel!.sumRepresentativeDue.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                         ],
                       ),
                     ),),
                     Card(
                       color: Theme.of(context).primaryColor,
                       shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                       child: Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Row(
                         children: [
                           Text(S.current.totalPayment +': '),
                           Text(balanceModel!.sumPaymentToRepresentative.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                         ],
                       ),
                     ),),

                   ],),
                 ),
               ))
     ],
      ),
    );
  }

  List<Widget> getProducts() {
    List<Widget> widgets = [];
    widgets.add(Padding(
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
    widgets.add(Padding(
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
    widgets.add(Padding(
      padding: EdgeInsets.only(left: 36.0, right: 36.0),
      child: Divider(
        color: Theme.of(screenState.context).disabledColor.withOpacity(0.1),
        thickness: 2.0,
      ),
    ));

    for (var element in balanceModel!.payments) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppThemeDataService.PrimaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(S.current.paymentAmount+': '),
                        Text(element.amount.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text(S.current.at),
                        Text(element.date.toString().split(' ').first),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                    color: Colors.grey[100]?.withOpacity(0.7),
                    thickness: 2,
                  ),
                ),
                Text(element.note)
              ],
            ),
          )
          ,),
      ));
    }
    return widgets;
  }
}

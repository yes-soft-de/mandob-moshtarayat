import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_balance/model/balance_model.dart';
import 'package:mandob_moshtarayat/module_balance/ui/screen/balance_info_screen.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';

import 'balance_state.dart';

class BalanceLoaded extends BalanceState{
  final BalanceScreenState screenState;
  final BalanceModel? model;
  final String? error;
  final bool empty;


  BalanceLoaded(this.screenState,this.model, {this.error, this.empty=false})  :super(screenState);

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
//          screenState.getStoreCategoriesLevelOne();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
//            screenState.getStoreCategoriesLevelOne();
          });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(S.current.sumPaymentsFromCompany+': '),
                Text(model!.sumPaymentsToStore.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),),
        ],
      ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(S.current.amountYouOwn +': '),
                  Text(model!.amountOwedToStore.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(S.current.total+': '+ model!.total.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
            ),),
          ],
        ),
        Expanded(
          child: CustomListView.custom(children: getProducts()),
        )
    ],);
  }
  List<Widget> getProducts() {
    List<Widget> widgets = [];
    for (var element in model!.payments) {
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
                        Text(S.current.currentBalance),
                        Text(element.amount.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text('At: '),
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
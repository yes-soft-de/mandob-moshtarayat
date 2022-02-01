import 'package:flutter/cupertino.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_stores/model/store_model.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/payment_method.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';

class  StoreLoadedState extends States {
  final StoreScreenState screenState;
  final  List<StoreModel>  storeModel;
  final String? error;
  final bool empty;

  StoreLoadedState(this.screenState,this.storeModel,
      {this.error, this.empty = false})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStores();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStores();
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),

                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: [0.2, 0.7],
                      colors: [
                        Colors.yellow.shade900,
                        Colors.orange.shade900,
                      ],
                    ),
                  ),

                  height: MediaQuery.of(context).size.height * .20,
                  padding: EdgeInsets.only(top: 20, left: 30, right: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[


                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        S.of(context).totalStore,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        storeModel.length.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              ListView.builder(itemBuilder:(context,index){
                return  PaymentMethods(
                  name: storeModel[index].storeName,
                  amount:  storeModel[index].phone,
                  image: storeModel[index].image??'',
                );
              } , itemCount: storeModel.length,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),),
            ],
          ),
    ]));
  }
}

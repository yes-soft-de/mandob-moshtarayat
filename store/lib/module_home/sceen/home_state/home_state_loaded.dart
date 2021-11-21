import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/consts/order_status.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/model/report_model.dart';
import 'package:mandob_moshtarayat/module_home/widget/animation.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/utils/global/screen_type.dart';

import '../home_screen.dart';

class HomeLoadedState extends States {
  final HomeScreenState screenState;
  final String? error;
  final bool empty;
  final ReportModel? model;
  final StoreProfileModel? profileModel;

  HomeLoadedState(this.screenState, this.model, this.profileModel,
      {this.empty = false, this.error})
      : super(screenState);

  String? id;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getReport();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
                    screenState.getReport();
          });
    }
    print('fgfgfgfgfgfgf');
    print(profileModel!.storeCategoryId);
    constCategoryID.id= profileModel!.storeCategoryId;
    print(constCategoryID.id);
    return SingleChildScrollView(
      physics:
      BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: SizedBox(
        child: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
            children: [
              widgetTile(model?.countOrdersInToday.toString() ?? '',S.current.countTodayOrder),
              Padding(
                padding: const EdgeInsets.only(right:32,left: 32),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
              ),
              widgetTile(model?.countCompletedOrders.toString() ?? '',S.current.countCompletedOrders),
          widgetTile(model?.countOngoingOrders.toString() ?? '',S.current.countOngoingOrders),
          Padding(
            padding: const EdgeInsets.only(right:32,left: 32),
            child: Divider(
              thickness: 2.5,
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
          ),
//          widgetTile(model?.countClients.toString() ?? '',S.current.countClients),
          widgetTile(model?.countProducts.toString() ?? '',S.current.countProducts),
            ]),
      ),
    );
  }
  Widget widgetTile(String count,String title) {
    return Container(
      width:!ScreenType.isDesktop() ? MediaQuery.of(screenState.context).size.width * 0.5 :  MediaQuery.of(screenState.context).size.width * 0.25,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: AnimatedLiquidCircularProgressIndicator(ValueKey(title),int.parse(count)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 180
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(screenState.context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(title,style: TextStyle(
                    fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class HomeLoadingState extends States {
  HomeLoadingState(HomeScreenState screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
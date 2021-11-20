import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/model/captains_report_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/model/store_report_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/screen/captains_reports_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/screen/stores_reports_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';

class StoresReportLoadedState extends States {
  final StoresReportScreenState screenState;
  final String? error;
  final bool empty;
  final List<StoresReportModel>? model;

  StoresReportLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }
  String? id;
  String? search;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getCaptains();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCaptains();
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: getReport(context)));
  }

  List<Widget> getReport(BuildContext context) {
    List<Widget> widgets = [];
    if (model == null) return [];
    if (model!.isEmpty) return [];
    for (var element in model!) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipOval(
                    child: CustomNetworkImage(
                      width: 50,
                      height: 50,
                      imageSource: element.image,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: 200,
                  child:
                      Text('${S.current.storeDid} ${element.storeOwnerName} ')),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 8.0, top: 8.0),
                      child: Icon(
                        FontAwesomeIcons.boxOpen,
                        color: Theme.of(context).disabledColor,
                        size: 18,
                      ),
                    ),
                    Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                            child: Text(
                          element.countOrdersInMonth.toString(),
                          style: TextStyle(color: Colors.white),
                        )))
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }
    return widgets;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
import 'package:mandob_moshtarayat_dashboad/utils/images/images.dart';

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
    if (screenState.fDate != null && screenState.lDate != null) {
      firstDate = screenState.fDate;
      lastDate = screenState.lDate;
    }
  }
  DateTime? firstDate;
  DateTime? lastDate;

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
    }
    return FixedContainer(
        child: CustomListView.custom(children: getReport(context)));
  }

  List<Widget> getReport(BuildContext context) {
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
    if (empty) {
      widgets.add(
        Center(child: Text(S.current.homeDataEmpty)),
      );
      widgets.add(SvgPicture.asset(
        SvgAsset.EMPTY_SVG,
        width: 150,
        height: 150,
      ));
      return widgets;
    }
    if (model == null) return [];
    if (model?.isEmpty == true) return [];
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

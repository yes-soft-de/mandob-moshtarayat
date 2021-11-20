import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/model/captain_filter_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/ui/screen/captain_filter_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/ui/widget/captain_card_filter.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';

class CaptainsFilterLoadedState extends States {
  final CaptainFilterScreenState screenState;
  final String? error;
  final bool empty;
  final List<CaptainFilterModel>? model;

  CaptainsFilterLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState);

  String? id;
  String? search;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.initFilterState();
        },
        error: error,
      );
    }
    return FixedContainer(
        child: CustomListView.custom(children: getCaptains(context)));
  }

  List<Widget> getCaptains(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in model ?? <CaptainFilterModel>[]) {
      widgets.add(CaptainFilterCard(
        captainId: element.captainID,
        captainName: element.captainName,
        image: element.image,
      ));
    }

    widgets.insert(
        0,
        Padding(
          padding:
              EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16, top: 16),
          child: CustomDeliverySearch(
            hintText: S.current.searchingForCaptain,
            onChanged: (s) {
              if (s == '' || s.isEmpty) {
                search = null;
                screenState.refresh();
              } else {
                search = s;
                screenState.refresh();
              }
            },
          ),
        ));
    widgets.insert(
        1,
        Padding(
          padding:
              EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16, top: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
            onPressed:
                search != null ? () => screenState.getFilters(search!) : null,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.current.search,
                style: TextStyle(color: search != null ? Colors.white : null),
              ),
            ),
          ),
        ));
    widgets.insert(
        2,
        Padding(
          padding: EdgeInsets.only(left: 36.0, right: 36.0),
          child: Divider(
            color: Theme.of(context).disabledColor.withOpacity(0.1),
            thickness: 2.0,
          ),
        ));

    return widgets;
  }
}

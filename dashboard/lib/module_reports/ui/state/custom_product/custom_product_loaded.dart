import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/model/custom_product_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/screen/custom_product_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat_dashboad/utils/effect/hidder.dart';

class CustomProductLoadedState extends States {
  final CustomProductScreenState screenState;
  final String? error;
  final bool empty;
  final List<CustomProductModel>? model;

  CustomProductLoadedState(this.screenState, this.model,
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
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: ListTile(
            leading: Hider(
              active: element.productImage?.image != null,
              child: SizedBox(
                width: 50,
                height: 50,
                child: ClipOval(
                  child: CustomNetworkImage(
                    height: 50,
                    width: 50,
                    imageSource: element.productImage?.image ?? '',
                  ),
                ),
              ),
            ),
            title: Text(
              element.productName,
            ),
            subtitle: Hider(
              active: element.detail != null,
              child: Text(
                element.detail ?? '',
              ),
            ),
          ),
        ),
      ));
    }
    return widgets;
  }
}

import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/linking_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/sub_categories_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';

class SubCategoriesListLoadedState extends States {
  final SubCategoriesListScreenState screenState;
  final String? error;
  final bool empty;
  final List<SubCategoriesModel>? model;

  SubCategoriesListLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {}
  }

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getSubCategories();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getSubCategories();
          });
    }
    return Container(
      width: double.maxFinite,
      child: Center(
        child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: CustomListView.custom(children: getStores())),
      ),
    );
  }

  List<Widget> getStores() {
    List<Widget> widgets = [];
    if (model == null) {
      return widgets;
    }
    if (model!.isEmpty) return widgets;
    for (var element in model!) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(screenState.context).primaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: CustomNetworkImage(
                      imageSource: element.image,
                      width: 75,
                      height: 75,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getTile(element.categoryName),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(screenState.context).pushNamed(
                      LinkingRoutes.STORE_CATEGORIES_LINKING,
                      arguments: element.id.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(screenState.context)
                        .backgroundColor
                        .withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.link,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
      ));
    }
    widgets.add(SizedBox(height: 75));
    return widgets;
  }

  Widget getTile(String text) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }
}

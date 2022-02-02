import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/model/store_categories_link_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/main_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/store_categories_linking_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';

class StoreCategoriesLinkingLoadedState extends States {
  final StoreCategoriesLinkingScreenState screenState;
  final String? error;
  final bool empty;
  List<StoreCategoriesLinksModel>? model;

  StoreCategoriesLinkingLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
  }

  String? search;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStoreCategories();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStoreCategories();
          });
    }
    return Container(
      width: double.maxFinite,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Expanded(
                child: CustomListView.custom(children: getCategories()),
              ),
              ElevatedButton(
                  onPressed: () async {
                    List<String> categories = [];
                    model?.forEach((element) {
                      if (element.linked) {
                        categories.add(element.id.toString());
                      }
                    });
                    screenState.updateCategory(MainLinkRequest(
                        mainCategoriesIDs: categories,
                        subCategoryLevelOneId:
                            int.parse(screenState.subCategories)));
                  },
                  child: Text(S.current.save)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getCategories() {
    var context = screenState.context;
    List<Widget> widgets = [];
    if (model == null) {
      return widgets;
    }
    if (model!.isEmpty) return widgets;
    for (var element in model ?? <StoreCategoriesLinksModel>[]) {
      if (!element.categoryName.contains(search ?? '') && search != null) {
        continue;
      }
      widgets.add(CheckboxListTile(
          value: element.linked,
          title: Text(element.categoryName),
          onChanged: (value) {
            element.linked = value ?? false;
            screenState.refresh();
          }));
    }

    if (model != null) {
      widgets.insert(
          0,
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16),
            child: CustomDeliverySearch(
              hintText: S.current.searchingForCategories,
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
    }
    widgets.add(SizedBox(
      height: 50,
    ));
    return widgets;
  }
}

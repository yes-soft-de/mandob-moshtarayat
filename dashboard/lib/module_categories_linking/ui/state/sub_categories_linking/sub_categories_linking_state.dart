import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/model/sub_categories_link_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/sub_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/sub_categories_linking_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';

class SubCategoriesLinkingLoadedState extends States {
  final SubCategoriesLinkingScreenState screenState;
  final String? error;
  final bool empty;
  List<SubCategoriesLinksModel>? model;

  SubCategoriesLinkingLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (model != null) {
      for (var element in model!) {
        if (element.linked) {
          oneSelected = true;
          model?.remove(element);
          model?.insert(0, element);
          break;
        }
      }
    }
  }
  bool oneSelected = false;
  String? search;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getProductsCategories();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getProductsCategories();
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
                  onPressed: id != null
                      ? () async {
                          screenState.updateCategory(SubLinkRequest(
                              subCategoryLevelTwoId:
                                  int.parse(screenState.subCategories),
                              subCategoryLevelOneId: int.parse(id!)));
                        }
                      : null,
                  child: Text(S.current.save)),
            ],
          ),
        ),
      ),
    );
  }

  String? id;
  List<Widget> getCategories() {
    var context = screenState.context;
    List<Widget> widgets = [];
    if (model == null) {
      return widgets;
    }
    if (model!.isEmpty) return widgets;
    for (var element in model ?? <SubCategoriesLinksModel>[]) {
      if (!element.categoryName.contains(search ?? '') && search != null) {
        continue;
      }
      widgets.add(CheckboxListTile(
          value: element.linked
              ? true
              : oneSelected
                  ? null
                  : false,
          selected: element.linked,
          autofocus: element.linked,
          tristate: element.linked ? false : oneSelected,
          title: Text(
            element.categoryName,
            style: TextStyle(
              fontWeight: element.linked ? FontWeight.bold : null,
              decoration: oneSelected && element.linked == false
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          onChanged: oneSelected && element.linked == false
              ? null
              : (value) {
                  if (value == true) {
                    id = element.id.toString();
                    element.linked = true;
                    oneSelected = true;
                  } else {
                    id = null;
                    element.linked = false;
                    oneSelected = false;
                  }
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

  Widget getTile(String text) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }
}

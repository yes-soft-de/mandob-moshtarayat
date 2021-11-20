import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/store_categories_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/widget/store_card.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/form_dialog.dart';

class StoreCategoriesLoadedState extends StoreCategoriesState {
  final StoreCategoriesScreenState screenState;
  final String? error;
  final bool empty;
  final List<StoreCategoriesModel>? model;

  StoreCategoriesLoadedState(this.screenState, this.model,
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
          child: CustomListView.custom(children: getCategories()),
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
    for (var element in model ?? <StoreCategoriesModel>[]) {
      if (!element.categoryName.contains(search ?? '') && search != null) {
        continue;
      }

      widgets.add(StoresCategoryCard(
        image: element.image,
        storeName: element.categoryName,
        dialog:
            formDialog(context, S.current.storeCategories, S.current.category,
                (name, image) {
          Navigator.of(context).pop();
          screenState.updateCategory(UpdateStoreCategoriesRequest(
              id: element.id,
              description: '',
              storeCategoryName: name,
              image: image));
        },
                storeCategoriesRequest: UpdateStoreCategoriesRequest(
                  id: element.id,
                  description: '',
                  storeCategoryName: element.categoryName,
                  image: element.image,
                  baseImage: element.baseImage
                )),
      ));
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

    return widgets;
  }
}

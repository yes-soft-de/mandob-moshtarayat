import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/categories_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/store_categories_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/widget/store_card.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/widget/order_details/custom_alert_dialog.dart';
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
        onEdit: () {
          Navigator.pushNamed(context, CategoriesRoutes.UPDATE_STORE_CATEGORIES,
                  arguments: element.id)
              .then((value) {
            if (value != null && value is bool && value) {
              screenState.getStoreCategoriesWithLang(
                  screenState.languageSelected ?? 'ar');
            }
          });
        },
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return CustomAlertDialog(
                    message: S.current.sureForDeleteCategories,
                    onPressed: () {
                      Navigator.of(context).pop();

                      screenState.deleteCategories(element.id.toString());
                    });
              });
        },
        dialog:
            formDialog(context, S.current.storeCategories, S.current.category,
                (name, image, tars) {
          Navigator.of(context).pop();
          screenState.updateCategory(UpdateStoreCategoriesRequest(
              dataStoreCategory: DataUpdateStoreCategory(
                  id: element.id,
                  storeCategoryName: name,
                  image: image,
                  lang: screenState.languageSelected),
              translate: screenState.languageSelected == 'ar'
                  ? []
                  : [
                      TranslateUpdateStoreCategory(
                          lang: screenState.languageSelected,
                          storeCategoryName: name,
                          storeCategoryID: element.id)
                    ]));
        },
                storeCategoriesRequest: UpdateStoreCategoriesRequest(
                    dataStoreCategory: DataUpdateStoreCategory(
                        id: element.id,
                        storeCategoryName: element.categoryName,
                        image: element.image,
                        baseImage: element.imageUrl,
                        lang: screenState.languageSelected))),
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
      widgets.insert(
          1,
          ListTile(
            trailing: DropdownButton(
                value: screenState.languageSelected,
                underline: Container(),
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_drop_down_rounded,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    child: Text(
                      'العربية',
                      style: TextStyle(),
                    ),
                    value: 'ar',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'English',
                      style: TextStyle(),
                    ),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Urdu',
                      style: TextStyle(),
                    ),
                    value: 'urdu',
                  ),
                ],
                onChanged: (newLang) {
                  screenState.languageSelected = newLang.toString();
                  screenState.getStoreCategoriesWithLang(newLang.toString());
                }),
          ));
    }
    widgets.add(SizedBox(
      height: 50,
    ));
    return widgets;
  }
}

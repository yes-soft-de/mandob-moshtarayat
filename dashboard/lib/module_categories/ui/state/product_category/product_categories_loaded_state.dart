import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/level_tow_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/widget/order_details/custom_alert_dialog.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';

import '../../../categories_routes.dart';

class ProductCategoriesLoadedState extends States {
  final LevelTowCategoriesScreenState screenState;
  final String? error;
  final bool empty;
  final List<SubCategoriesModel>? subCategories;
  final List<StoreCategoriesModel>? categories;
  final List<SubCategoriesModel>? subCategoriesLevelTow;

  ProductCategoriesLoadedState(
      this.screenState, this.subCategories, this.categories,
      {this.subCategoriesLevelTow, this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
  }

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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      //color: Theme.of(context).backgroundColor,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 4)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16),
                    child: DropdownButton(
                      value: screenState.mainCatId,
                      items: getChoices(),
                      onChanged: (v) {
                        if (v != 'all') {
                          screenState.mainCatId = v.toString();
                          screenState.getSubCategories(categories);
                          screenState.refresh();
                        } else {
                          screenState.getStoreCategories();
                          screenState.refresh();
                        }
                      },
                      hint: Text(
                        S.current.chooseCategory,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      underline: SizedBox(),
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.arrow_drop_down_rounded),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      //color: Theme.of(context).backgroundColor,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 4)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16),
                    child: DropdownButton(
                      value: screenState.subCatId,
                      items: getSubCategories(),
                      onChanged: (v) {
                        screenState.subCatId = v.toString();
                        screenState.getSubCategoriesLevelTow(
                            categories, subCategories);
                        screenState.refresh();
                      },
                      hint: Text(
                        S.current.chooseCategory,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      underline: SizedBox(),
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.arrow_drop_down_rounded),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CustomListView.custom(children: getStores(context)),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getChoices() {
    List<DropdownMenuItem<String>> items = [];
    items.add(DropdownMenuItem(
      value: 'all',
      child: SizedBox(
          width: 250,
          child: Text(S.current.showAll, overflow: TextOverflow.ellipsis)),
    ));
    categories?.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: SizedBox(
            width: 250,
            child: Text(
              element.categoryName,
              overflow: TextOverflow.ellipsis,
            )),
      ));
    });
    return items;
  }

  List<DropdownMenuItem<String>> getSubCategories() {
    List<DropdownMenuItem<String>> items = [];
    subCategories?.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: SizedBox(
            width: 250,
            child: Text(
              element.categoryName,
              overflow: TextOverflow.ellipsis,
            )),
      ));
    });
    return items;
  }

  List<Widget> getStores(BuildContext context) {
    List<Widget> widgets = [];
    if (subCategoriesLevelTow == null) {
      return widgets;
    }
    if (subCategoriesLevelTow!.isEmpty) return widgets;
    for (var element in subCategoriesLevelTow!) {
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
                  Navigator.pushNamed(
                          context, CategoriesRoutes.UPDATE_PRODUCT_CATEGORIES,
                          arguments: element.id)
                      .then((value) {
                    if (value != null && value is bool && value) {
                      screenState.getSubCategoriesLevelTow(
                          categories, subCategories);
                    }
                  });
//                  showDialog(
//                      barrierDismissible: false,
//                      context: screenState.context,
//                      builder: (context) {
//                        return Container(
//                          width: MediaQuery.of(context).size.width,
//                          height: MediaQuery.of(context).size.height,
//                          child: Scaffold(
//                            appBar: CustomTwaslnaAppBar.appBar(context,
//                                title: S.current.addNewCategory),
//                            backgroundColor:
//                                Theme.of(context).scaffoldBackgroundColor,
//                            body: AddSubCategoriesLevelTowWidget(
//                              state: this,
//                              catID: screenState.mainCatId,
//                              subCatID: screenState.subCatId,
//                              languages: [],
//                              subCategoriesModel: element,
//                              addSubCategories: (id, subId, name, image, trs) {
//                                screenState.updateCategoryLevel2(
//                                    CategoryLevelTowRequest(
//                                  translate: screenState.languageSelected ==
//                                          'ar'
//                                      ? []
//                                      : [
//                                          TranslateSubTwoCategory(
//                                              lang:
//                                                  screenState.languageSelected,
//                                              productCategoryName: name,
//                                              productCategoryID: element.id)
//                                        ],
//                                  dataStoreCategory: DataStoreCategoryTwo(
//                                      storeProductCategoryID: int.parse(subId),
//                                      productCategoryName: name,
//                                      productCategoryImage: image,
//                                      id: element.id),
//                                ));
//                              },
//                            ),
//                          ),
//                        );
//                      });
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
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: screenState.context,
                      builder: (context) {
                        return CustomAlertDialog(
                            message: S.current.sureForDeleteCategories,
                            onPressed: () {
                              Navigator.of(context).pop();
                              screenState
                                  .deleteSubCategories(element.id.toString());
                            });
                      });
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
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
            ],
          ),
        ),
      ));
    }
    if (subCategoriesLevelTow != null) {
      widgets.insert(
          0,
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
                  screenState.refresh();
                  screenState.getSubCategoriesLevelTow(
                      categories, subCategories);
                }),
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

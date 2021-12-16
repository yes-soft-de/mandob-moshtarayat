import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/sub_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/sub_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/widget/sub_categories.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/ui/widget/order_details/custom_alert_dialog.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';

class SubCategoriesLoadedState extends States {

  final SubCategoriesScreenState screenState;
  final String? error;
  final bool empty;
  final List<SubCategoriesModel>? model;
  final List<StoreCategoriesModel>? categories;

  SubCategoriesLoadedState(this.screenState, this.model, this.categories,
      {this.empty = false, this.error})
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
          screenState.getMainCategories();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getMainCategories();
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
                  child: Center(
                    child: DropdownButton(
                      value: screenState.id,
                      items: getChoices(),
                      onChanged: (v) {
                        screenState.id = v.toString();
                        screenState.getSubCategories(categories);
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
                child: CustomListView.custom(children: getStores()),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getChoices() {
    List<DropdownMenuItem<String>> items = [];
    categories?.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    return items;
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
                  showDialog(
                      barrierDismissible: false,
                      context: screenState.context,
                      builder: (context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Scaffold(
                            appBar: CustomTwaslnaAppBar.appBar(context,
                                title: S.current.updateCategory),
                            backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                            body: AddSubCategoriesWidget(
                              catID: screenState.id,
                              state: this,
                              languages: [],
                              subCategoriesModel: element,
                              selectedLang: screenState.languageSelected,
                              addSubCategories: (id , name , image,tras) {
                                Navigator.of(context).pop();
                                screenState.updateSubCategories(SubCategoriesRequest(
                                 translate:screenState.languageSelected =='ar'? [] : [TranslateSubCategory(lang: screenState.languageSelected,productCategoryName: name,productCategoryID: element.id)],
                                  dataStoreCategory: DataStoreCategory(storeCategoryID:int.tryParse(id),productCategoryImage: image,productCategoryName: name,id: element.id ),
                                ));
                              },
                            ),
                          ),
                        );
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
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8,), 
              InkWell(
                onTap: () {
                showDialog(
              context: screenState.context,
              builder: (context) {
                return CustomAlertDialog(
                    message: S.current.sureForDeleteCategories,
                    onPressed: () {
                              Navigator.of(context).pop();

                      screenState.deleteSubCategories(element.id.toString());
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
              SizedBox(width: 8,), 
            ],
          ),
        ),
      ));
    }
    if (model != null) {
      widgets.insert(
          0,
          ListTile(
            trailing: DropdownButton(
                value: screenState.languageSelected,
                underline: Container(),
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.arrow_drop_down_rounded,),
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
                  screenState.getSubCategories(categories);
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

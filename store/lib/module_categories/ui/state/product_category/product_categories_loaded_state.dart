import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_category_request.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/product_categories_screen.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_state.dart';
// import 'package:mandob_moshtarayat/module_stores/stores_routes.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/helpers/form_dialog.dart';

class ProductCategoriesLoadedState extends ProductCategoriesState {
  final ProductCategoriesScreenState screenState;
  final String? error;
  final bool empty;
  final List<ProductsCategoryModel>? categoriesOne;
  final List<ProductsCategoryModel>? categoriesTwo;
  final List<ProductsModel>? products;

  ProductCategoriesLoadedState(this.screenState, this.categoriesOne,this.categoriesTwo,this.products,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
  }
    String? catId = '-1';
  String? idOne;
  String? idTwo;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStoreCategoriesLevelOne();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStoreCategoriesLevelOne();
          });
    }
    return Container(
      width: double.maxFinite,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: 600
          ),
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
                      value: idOne,
                      items: getChoicesCategoriesOne(),
                      onChanged: (v) {
                        idOne = v.toString();
                        screenState.getStoreCategoriesLevelTwo(categoriesOne??[], int.parse(idOne??'0'));
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
                  child: Center(
                    child: DropdownButton(
                      value: idTwo,
                      items: getChoicesCategoriesTwo(),
                      onChanged: (v) {
                        idTwo = v.toString();
                        // screenState.get();
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
            ],
          ),
        ),
      ),
    );

  }
  List<DropdownMenuItem<String>> getChoicesCategoriesOne() {
    List<DropdownMenuItem<String>> items = [];
    categoriesOne?.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    return items;
  }
  List<DropdownMenuItem<String>> getChoicesCategoriesTwo() {
    List<DropdownMenuItem<String>> items = [];
    categoriesTwo?.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    return items;
  }
}

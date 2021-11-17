import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/level_tow_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/product_category/product_categories_state.dart';

class ProductCategoriesLoadingState extends ProductCategoriesState {
  ProductCategoriesLoadingState(LevelTowCategoriesScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

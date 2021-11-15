import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/product_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/product_category/product_categories_state.dart';

class ProductCategoriesLoadingState extends ProductCategoriesState {
  ProductCategoriesLoadingState(ProductCategoriesScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

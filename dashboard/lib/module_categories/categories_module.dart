import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/categories_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/level_tow_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/sub_categories_screen.dart';

import 'ui/screen/update_categories_screen/update_level_two_category_screen.dart';
import 'ui/screen/update_categories_screen/update_store_category_screen.dart';
import 'ui/screen/update_categories_screen/update_sub_category_screen.dart';

@injectable
class CategoriesModule extends YesModule {
  final StoreCategoriesScreen storeCategoriesScreen;
  final LevelTowCategoriesScreen productCategoriesScreen;
  final StoreProductScreen productStoreCategoriesScreen;
  final SubCategoriesScreen subCategoriesScreen;

  final UpdateStoreCategoryScreen updateStoreCategoryScreen;
  final UpdateSubCategoryScreen updateSubCategoryScreen;
  final UpdateLevelTwoCategoryScreen updateLevelTwoCategoryScreen;


  CategoriesModule(this.storeCategoriesScreen, this.productCategoriesScreen,
      this.productStoreCategoriesScreen, this.subCategoriesScreen, this.updateStoreCategoryScreen, this.updateSubCategoryScreen, this.updateLevelTwoCategoryScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CategoriesRoutes.STORE_CATEGORIES: (context) => storeCategoriesScreen,
      CategoriesRoutes.PRODUCT_CATEGORIES: (context) => productCategoriesScreen,
      CategoriesRoutes.PRODUCT_STORE_CATEGORIES: (context) =>
          productStoreCategoriesScreen,
      CategoriesRoutes.SUB_CATEGORIES: (context) => subCategoriesScreen,

      CategoriesRoutes.UPDATE_STORE_CATEGORIES: (context) => updateStoreCategoryScreen,
      CategoriesRoutes.UPDATE_SUB_CATEGORIES: (context) => updateSubCategoryScreen,
      CategoriesRoutes.UPDATE_PRODUCT_CATEGORIES: (context) => updateLevelTwoCategoryScreen,
    };
  }
}

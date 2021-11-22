import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/categories_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/level_tow_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/sub_categories_screen.dart';

@injectable
class CategoriesModule extends YesModule {
  final StoreCategoriesScreen storeCategoriesScreen;
  final LevelTowCategoriesScreen productCategoriesScreen;
  final StoreProductScreen productStoreCategoriesScreen;
  final SubCategoriesScreen subCategoriesScreen;
  CategoriesModule(this.storeCategoriesScreen, this.productCategoriesScreen,
      this.productStoreCategoriesScreen,this.subCategoriesScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CategoriesRoutes.STORE_CATEGORIES: (context) => storeCategoriesScreen,
      CategoriesRoutes.PRODUCT_CATEGORIES: (context) => productCategoriesScreen,
      CategoriesRoutes.PRODUCT_STORE_CATEGORIES: (context) =>
          productStoreCategoriesScreen,
      CategoriesRoutes.SUB_CATEGORIES : (context) => subCategoriesScreen
    };
  }
}

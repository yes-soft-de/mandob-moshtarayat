import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_categories/categories_routes.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/product_categories_screen.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/store_products_screen.dart';

@injectable
class CategoriesModule extends YesModule {
  final ProductCategoriesScreen productCategoriesScreen;
  final StoreProductScreen productStoreCategoriesScreen;
  CategoriesModule(this.productCategoriesScreen,this.productStoreCategoriesScreen){
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      CategoriesRoutes.PRODUCT_CATEGORIES : (context) => productCategoriesScreen,
      CategoriesRoutes.PRODUCT_STORE : (context) => productStoreCategoriesScreen
    };
  }
}
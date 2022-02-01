import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_products/products_routes.dart';
import 'package:mandob_moshtarayat/module_products/ui/screen/cart_screen.dart';
import 'package:mandob_moshtarayat/module_products/ui/screen/products_details_screen.dart';

@injectable
class ProductsModule extends YesModule {
  final ProductDetailsScreen _productDetailsScreen;
  final CartScreen _cartScreen;
  ProductsModule(this._productDetailsScreen, this._cartScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ProductsRoutes.PRODUCT_DETAILS_SCREEN: (context) => _productDetailsScreen,
      ProductsRoutes.CART_SCREEN: (context) => _cartScreen
    };
  }
}


import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/product_categories_screen.dart';

abstract class ProductCategoriesState {
  final ProductCategoriesScreenState state;

  ProductCategoriesState(this.state);
  Widget getUI(BuildContext context);
}
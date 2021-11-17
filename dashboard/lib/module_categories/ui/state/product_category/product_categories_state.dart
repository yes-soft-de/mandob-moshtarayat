import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/level_tow_categories_screen.dart';

abstract class ProductCategoriesState {
  final LevelTowCategoriesScreenState state;

  ProductCategoriesState(this.state);
  Widget getUI(BuildContext context);
}

import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_categories_screen.dart';

abstract class StoreCategoriesState {
  final StoreCategoriesScreenState state;

  StoreCategoriesState(this.state);
  Widget getUI(BuildContext context);
}

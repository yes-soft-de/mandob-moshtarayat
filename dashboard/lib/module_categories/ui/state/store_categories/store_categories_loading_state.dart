import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/store_categories_state.dart';

class StoreCategoriesLoadingState extends StoreCategoriesState {
  StoreCategoriesLoadingState(StoreCategoriesScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

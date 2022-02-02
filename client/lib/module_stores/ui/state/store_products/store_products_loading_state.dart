import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_state.dart';

class StoreProductsLoadingState extends StoreProductsState {
  StoreProductsLoadingState(StoreProductsScreenState screenState)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

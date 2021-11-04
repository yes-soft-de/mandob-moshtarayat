import 'package:flutter/cupertino.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_products_screen.dart';

abstract class StoreProductsState {
  final StoreProductsScreenState storeProductsScreenState;
  StoreProductsState(this.storeProductsScreenState);
  Widget getUI(BuildContext context);
}

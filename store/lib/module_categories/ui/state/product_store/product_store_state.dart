import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/product_component.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';

class ProductStoreState extends States {
  final StoreProductScreenState screenState;
  final List<ProductsModel>? productsModel;
  final String? error;
  final bool empty;

  ProductStoreState(this.screenState,this.productsModel,{this.empty = false, this.error}) : super (screenState) {
    if (error != null) {
      screenState.save = false;
      screenState.refresh();
    }
  }
  String? id ;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStoreProducts();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStoreProducts();
          });
    }
    return FixedContainer(child: Column(
      children: [
        Expanded(
          child: CustomListView.custom(children:getProducts()),
        )
      ],
    ));
  }
  List<Widget> getProducts() {
    List<Widget> widgets = [];
    if (productsModel == null) {
      return widgets;
    }

    if (productsModel!.isEmpty) return widgets;
    for (var element in productsModel!) {
      if (id != null && id != element.storeProductCategoryID.toString()) {
        continue;
      }
      widgets.add(          ProductComponent(discount: element.discount.toString(),description: '',image: element.productImage.image??'',rating: 0,title: element.productName, productId: element.id.toString(),price: element.productPrice.toString())
      );
    }
    return widgets;
  }

//  List<DropdownMenuItem<String>> getChoices() {
//    List<DropdownMenuItem<String>> items = [];
//    model?.forEach((element) {
//      items.add(DropdownMenuItem(
//        value: element.id.toString(),
//        child: Text(element.categoryName),
//      ));
//    });
//    return items;
//  }


}
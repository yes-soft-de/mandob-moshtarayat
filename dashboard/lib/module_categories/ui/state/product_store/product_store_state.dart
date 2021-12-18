import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/widget/add_product_form.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/widget/product_card.dart';
import 'package:mandob_moshtarayat_dashboad/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';

class ProductStoreState extends States {
  final StoreProductScreenState screenState;
  final List<ProductsCategoryModel>? model;
  final List<ProductsModel>? productsModel;
  final String? error;
  final bool empty;

  ProductStoreState(this.screenState, this.model, this.productsModel,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.save = false;
      screenState.refresh();
    }
  }
  String? id;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getProductsCategories();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getProductsCategories();
          });
    }
    return FixedContainer(
        child: Column(
      children: [
//        Padding(
//          padding: const EdgeInsets.all(10.0),
//          child: Container(
//            width: double.maxFinite,
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(25),
//                //color: Theme.of(context).backgroundColor,
//                border: Border.all(
//                    color: Theme.of(context).primaryColor, width: 4)),
//            child: Center(
//              child: DropdownButton(
//                value: id,
//                items: getChoices(),
//                onChanged: (v) {
//                  id = v.toString();
//                  screenState.refresh();
//                },
//                hint: Text(
//                  S.current.chooseCategory,
//                  style: TextStyle(fontWeight: FontWeight.bold),
//                ),
//                underline: SizedBox(),
//                icon: Padding(
//                  padding: const EdgeInsets.all(4.0),
//                  child: Icon(Icons.arrow_drop_down_rounded),
//                ),
//              ),
//            ),
//          ),
//        ),
        Expanded(
          child: CustomListView.custom(children: getProducts()),
        )
      ],
    ));
  }

//  List<Widget> getProducts() {
//    List<Widget> widgets = [];
//    if (productsModel == null) {
//      return widgets;
//    }
//
//    if (productsModel!.isEmpty) return widgets;
//    for (var element in productsModel!) {
//      if (id != null && id != element.storeProductCategoryID.toString()) {
//        continue;
//      }
//      widgets.add(ProductCard(
//        productName: element.productName,
//        productImage: element.productImage,
//        dialog: UpdateProductsForm(
//          request: UpdateProductRequest(
//              productName: element.productName,
//              productImage: element.productImage,
//              productPrice: element.productPrice.toDouble()),
//          addProduct: (name, price, image) {
//            Navigator.of(screenState.context).pop();
//            screenState.updateProduct(UpdateProductRequest(
//                id: element.id,
//                productName: name,
//                productImage: image,
//                productPrice: double.parse(price),
//                storeProductCategoryID: element.storeProductCategoryID,
//                storeOwnerProfileID: element.storeOwnerProfileID));
//          },
//        ),
//      ));
//    }
//    return widgets;
//  }
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
      widgets.add(Row(
        children: [
          Expanded(
            child: ProductComponent(
                discount: element.discount.toString(),
                description: '',
                image: element.productImage.image ?? '',
                rating: 0,
                title: element.productName,
                productId: element.id.toString(),
                price: element.productPrice.toString()),
          ),
          InkWell(
            onTap: (){
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: Container(
                decoration: BoxDecoration(
                    color: AppThemeDataService.AccentColor,
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.edit),
                ),
              ),
            ),
          ),
        ],
      ));
    }
    return widgets;
  }
  List<DropdownMenuItem<String>> getChoices() {
    List<DropdownMenuItem<String>> items = [];
    model?.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    return items;
  }
}

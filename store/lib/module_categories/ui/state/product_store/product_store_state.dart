import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/add_product_form.dart';
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
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius:BorderRadius.circular(25),
          onTap: (){
            //   Navigator.of(screenState.context).pushNamed(StoresRoutes.STORES,arguments: element.id.toString());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(screenState.context).primaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CustomNetworkImage(
                        imageSource: element.productImage.image??'',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      element.productName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      element.productPrice.toString() +' S.R',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
Container()

//                InkWell(
//                  customBorder: CircleBorder(),
//                  onTap: (){
//                    showDialog(context: screenState.context, builder:(context){
//                      return UpdateProductsForm(
//                        request: UpdateProductRequest(
//                          productName: element.productName,
//                          productImage: element.productImage.image??'',
//                          productPrice: element.productPrice.toDouble()
//                        ),
//                        addProduct: (name,price,image){
//                          Navigator.of(context).pop();
////                         screenState.updateProduct(UpdateProductRequest(
////                              id: element.id,
////                              productName: name,
////                              productImage: image,
////                              productPrice:double.parse(price),
////                              storeProductCategoryID:element.storeProductCategoryID,
////                              // storeOwnerProfileID: element.storeOwnerProfileID
////                          ));
//                        },
//                      );
//                    });
//                  },
//                  child: Padding(
//                    padding: const EdgeInsets.all(16.0),
//                    child: Container(
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                        color: Theme.of(screenState.context).backgroundColor.withOpacity(0.2),
//                      ),
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Icon(
//                          Icons.edit,
//                          color: Colors.white,
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
              ],
            ),
          ),
        ),
      ));
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
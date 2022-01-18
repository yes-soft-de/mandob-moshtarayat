import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/add_product_form.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/category_card.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/product_component.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';

class ProductStoreState extends States {
  final StoreProductScreenState screenState;
  final List<ProductsModel>? productsModel;
  final List<ProductsCategoryModel>? categoriesOne;
  final List<ProductsCategoryModel>? categoriesTwo;
   int? idOne;
   int? idTwo;
  final String? error;
  final bool empty;

  ProductStoreState(this.screenState, this.productsModel, this.categoriesOne,
      this.categoriesTwo,{this.idOne ,this.idTwo ,
      this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.save = false;
      screenState.refresh();
    }
  }
  String? id;
  late List<ProductsModel> newDataList = productsModel??[] ;
   late List<ProductsModel> mainDataList=productsModel??[]  ;
  TextEditingController nameController = TextEditingController();
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getCategoriesLevelOneWithAllProducts('');
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCategoriesLevelOneWithAllProducts('');
          });
    }
    return FixedContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
      children: [
          CustomDeliverySearch(hintText: S.of(context).search,onChanged: (name){
//            newDataList = mainDataList
//                .where((string) => string.productName.toLowerCase().contains(name.toLowerCase()))
//                .toList();
//            screenState.refresh();
          screenState.getCategoriesLevelOneWithAllProducts(name);
          },controller: nameController,),
          SizedBox(
            height: 55,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CategoryCard(
                  title: categoriesOne![index].categoryName,
                  selected: categoriesOne![index].id == idOne ?true :false,
                  id: categoriesOne![index].id,
                  onTap: (id) {
                    print('hihih');
                idOne = id;
                screenState.getCategoriesLevelTwoWithProducts( id,categoriesOne);
                  },
                );
              },
              itemCount: categoriesOne!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height:categoriesTwo!.isEmpty ? 0: 60,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CategoryCard(
                  title: categoriesTwo![index].categoryName,
                  selected: categoriesTwo![index].id == idTwo ?true :false,
                  id: categoriesTwo![index].id,
                  onTap: (id) {
                idTwo = id;
               screenState.getStoreProductLevelTwo(idTwo??-1,idOne??-1 ,categoriesOne, categoriesTwo);
                  },
                );
              },
              itemCount: categoriesTwo!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Expanded(
            child: CustomListView.custom(children: getProducts()),
          )
      ],
    ),
        ));
  }

  List<Widget> getProducts() {
    List<Widget> widgets = [];
    if (newDataList == null) {
      return widgets;
    }

    if (newDataList.isEmpty) return widgets;
    for (var element in productsModel!) {
      if (id != null && id != element.storeProductCategoryID.toString()) {
        continue;
      }
      widgets.add(
          Row(
            children: [
              Expanded(child: ProductComponent(discount: element.discount.toString(),description: '',image: element.productImage.image??'',rating: 0,title: element.productName, productId: element.id.toString(),price: element.productPrice.toString(),)),
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      showDialog(context: screenState.context, builder:(context){
                        return UpdateProductsForm(
                          categoriesService: screenState.widget.categoriesService,
                          categoriesOne: getChoicesOne(),
                          categoriesTwo: getChoicesTwo(),
                          request: UpdateProductRequest(
                            dataStoreProduct: DataStoreUpdateProduct(
                                productName: element.productName,
                                productImage: element.productImage.image??'',
                                productPrice: element.productPrice.toDouble(),
                                discount: element.discount,
                                productQuantity: element.productQuantity,
                                storeProductCategoryID: element.storeProductCategoryID,
                              isLevelTwo: element.levelTwo,
                              isLevelOne: element.levelOne
                            ),

                          ),
                          addProduct: (name,price,image,discount,catID){
                            Navigator.of(context).pop();
                            screenState.updateProduct(UpdateProductRequest(
                              dataStoreProduct: DataStoreUpdateProduct(
                                  id: element.id,
                                  productName: name,
                                  productImage: image,
                                  discount: double.parse(discount),
                                  productPrice:double.parse(price),
                                  storeProductCategoryID:int.parse(catID),
                              ),

                            ), categoriesOne??[],);
                          },
                        );
                      });
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
                  SizedBox(height: 8,),
                  InkWell(
                    onTap: (){
                      screenState.updateProductStatus(
                          UpdateProductStatusRequest(
                              status: 'inactive',
                              id: element.id,
                              storeProductCategoryID:element.storeProductCategoryID,
                              storeMainCategoryID: -1
                          ),categoriesOne??[]);
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppThemeDataService.AccentColor,
                            shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
      );
    }
    return widgets;
  }

//  void onItemChanged(String value) {
//    setState(() {
//
//    });
//  }
  List<DropdownMenuItem<String>> getChoicesOne() {
    List<DropdownMenuItem<String>> items = [];
    categoriesOne?.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    return items;
  }
  List<DropdownMenuItem<String>> getChoicesTwo() {
    List<DropdownMenuItem<String>> items = [];
    categoriesTwo?.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    return items;
  }
}

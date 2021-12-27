import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/product_categories_screen.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_state.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/add_product_form.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/category_card.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/product_component.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/catagories_card.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';


class ProductCategoriesLoadedState extends ProductCategoriesState {
  final ProductCategoriesScreenState screenState;
  final String? error;
  final bool empty;
  final List<ProductsCategoryModel> categoriesOne;
  final List<ProductsCategoryModel> categoriesTwo;
  final List<ProductsModel> productsModel;
  final int storeProductCategoryID;
  final String? nameOne;
  final String? nameTwo;
  final int? idFirstCat;

  ProductCategoriesLoadedState(this.screenState, this.categoriesOne,this.categoriesTwo,this.productsModel, this.storeProductCategoryID,
      {this.nameOne, this.nameTwo,this.empty = false, this.error,this.idFirstCat,})
      : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
  }
    String? catId = '-1';
  ProductsCategoryModel? idOne;
  ProductsCategoryModel? idTwo;

//  String? NameOne;
//  String? NameTwo;

  int selectedIndex = 0;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStoreCategoriesLevelOne();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStoreCategoriesLevelOne();
          });
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
//        SizedBox(
//          height: 70,
//          child: ListView.builder(itemBuilder: (context , index){
//            return CategoryCard(title: categoriesOne[index].categoryName,
//
//              selected: categoriesOne[index].categoryName == nameOne ? true :false,
//
//              id: categoriesOne[index].id,
//              onTap: (id){
//              print('hihih');
//              idOne = categoriesOne[index];
//              screenState.getStoreCategoriesLevelTwo(categoriesOne, int.parse(idOne!.id.toString()),idOne!.categoryName);
//            },
//            );
//          },itemCount: categoriesOne.length,  shrinkWrap: true, scrollDirection: Axis.horizontal,),
//        ),
//        SizedBox(
//          height: 70,
//          child:
//          ListView.builder(itemBuilder: (context , index){
//            return CategoryCard(title: categoriesTwo[index].categoryName,
//                selected: categoriesTwo[index].categoryName == nameTwo ? true :false,
//              id: categoriesTwo[index].id, onTap: (id){
//              idTwo = categoriesTwo[index];
//             screenState.getStoreProductLevelTwo(categoriesOne, categoriesTwo, int.parse(idTwo!.id.toString()),nameOne??'',idTwo!.categoryName);
//              },
//            );
//          },itemCount: categoriesTwo.length,  shrinkWrap: true, scrollDirection: Axis.horizontal,),
//        ),
//        Expanded(
//          child: CustomListView.custom(children:getProducts()),
//        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                //color: Theme.of(context).backgroundColor,
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 4)),
            child: Center(
              child: DropdownButton(
                value: idOne,
                items: getChoicesCategoriesOne(),
                onChanged: (v) {
                  v as ProductsCategoryModel;
                  idOne = v;
                  screenState.getStoreCategoriesLevelTwo(categoriesOne, int.parse(idOne!.id.toString()),idOne!.categoryName);
                },
                hint: Text(
                nameOne ??  S.current.chooseCategory,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                underline: SizedBox(),
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.arrow_drop_down_rounded),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                //color: Theme.of(context).backgroundColor,
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 4)),
            child: Center(
              child: DropdownButton(
                value: idTwo,
                items: getChoicesCategoriesTwo(),
                onChanged: (v) {
                  v as ProductsCategoryModel;
                  idTwo = v;
                   screenState.getStoreProductLevelTwo(categoriesOne, categoriesTwo, int.parse(idTwo!.id.toString()),nameOne??'',idTwo!.categoryName);
                },
                hint: Text(
                nameTwo??  S.current.chooseCategory,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                underline: SizedBox(),
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.arrow_drop_down_rounded),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: CustomListView.custom(children:getProducts()),
        ),
        ElevatedButton(
          onPressed: (){
            if (nameOne != null){
              print("storeProductCategoryID" +idTwo.toString());
              showDialog(context: context, builder:(_){
                return AddProductsForm(
                  lang: screenState.language,
                  state:this,
                  languages: ['ar','en','ur'],
                  addProduct: (name,image,price,discount,trans){
                    Navigator.of(context).pop();
                    screenState.createProduct(CreateProductRequest(
                      dataStoreProduct: DataStoreProduct(
                        productName: name,
                        productImage: image,
                        productPrice: price,
                        discount: discount,
                        storeProductCategoryID: storeProductCategoryID,
                      ),translate: trans

                    ),categoriesOne,categoriesTwo,nameOne: nameOne,nameTwo: nameTwo);
                  },
                );
              });
            }else{
              Fluttertoast.showToast(msg: S.of(context).chooseCategory);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(S.current.addProducts,style: TextStyle(
                color: Colors.white
            ),),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 3
          ),
        ),
        SizedBox(height: 5,)
      ],
    );

  }
  List<DropdownMenuItem<ProductsCategoryModel>> getChoicesCategoriesOne() {
    List<DropdownMenuItem<ProductsCategoryModel>> items = [];
    categoriesOne.forEach((element) {
      items.add(DropdownMenuItem(
        value: element,
        child: Text(element.categoryName),
      ));
    });
    return items;
  }
  List<DropdownMenuItem<String>> getChoicesOne() {
    List<DropdownMenuItem<String>> items = [];
    categoriesOne.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    return items;
  }
  List<DropdownMenuItem<String>> getChoicesTwo() {
    List<DropdownMenuItem<String>> items = [];
    categoriesTwo.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id.toString(),
        child: Text(element.categoryName),
      ));
    });
    return items;
  }
  List<DropdownMenuItem<ProductsCategoryModel>> getChoicesCategoriesTwo() {
    List<DropdownMenuItem<ProductsCategoryModel>> items = [];
    categoriesTwo.forEach((element) {
      items.add(DropdownMenuItem(
        value: element,
        child: Text(element.categoryName),
      ));
    });
    return items;
  }

  List<Widget> getProducts() {
    List<Widget> widgets = [];
    if (productsModel == null) {
      return widgets;
    }

    if (productsModel.isEmpty) return widgets;
    for (var element in productsModel) {
      if (idTwo != null && idTwo != element.storeProductCategoryID.toString()) {
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
                          request: UpdateProductRequest(
                            dataStoreProduct: DataStoreUpdateProduct(
                              productName: element.productName,
                              productImage: element.productImage.image??'',
                              productPrice: element.productPrice.toDouble(),
                              discount: element.discount,
                              productQuantity: element.productQuantity,
                              storeProductCategoryID: element.storeProductCategoryID,
                              isLevelOne: element.levelOne,isLevelTwo: element.levelTwo
                            ),

                          ),
                          categoriesOne: getChoicesOne(),
                          categoriesTwo: getChoicesTwo(),
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
                                  storeMainCategoryID: idFirstCat
                              ),

                            ),
                                categoriesOne,categoriesTwo,nameTwo: nameTwo,nameOne: nameOne);
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
                          storeMainCategoryID: idFirstCat??-1
                      ),categoriesOne,categoriesTwo,nameTwo: nameTwo,nameOne: nameOne);
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


  List<Widget> getCategory() {
    List<CategoryCard> widgets = [];
    if (productsModel == null) {
      return widgets;
    }

    if (productsModel.isEmpty) return widgets;
    for (var element in categoriesOne) {
//      if (idTwo != null && idTwo != element.storeProductCategoryID.toString()) {
//        continue;
//      }
      widgets.add(
          CategoryCard(title: element.categoryName,id: element.id,selected: false,onTap: (id){},)
      );
    }
    return widgets;
  }
}

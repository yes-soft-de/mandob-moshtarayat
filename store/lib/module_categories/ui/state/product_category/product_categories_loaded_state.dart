import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_products_response.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/product_categories_screen.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_state.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/add_product_form.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/category_card.dart';
import 'package:mandob_moshtarayat/module_categories/ui/widget/product_component.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

class ProductCategoriesLoadedState extends ProductCategoriesState {
  final ProductCategoriesScreenState screenState;
  final String? error;
  final bool empty;
  final List<ProductsCategoryModel> categoriesOne;
  final List<ProductsCategoryModel> categoriesTwo;
  final List<ProductsModel> productsModel;
  ProductCategoriesLoadedState(
    this.screenState,
    this.categoriesOne,
    this.categoriesTwo,
    this.productsModel, {
    this.empty = false,
    this.error,
  }) : super(screenState) {
    if (error != null) {
      screenState.canAddCategories = false;
      screenState.refresh();
    }
  }

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
              child: DropdownSearch<ProductsCategoryModel>(
                  showSearchBox: true,
                  enabled: categoriesOne.isNotEmpty,
                  dropdownBuilder: (context, model) {
                    return Text(
                      model?.categoryName ?? S.current.chooseCategory,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                  dropdownSearchDecoration: InputDecoration(
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0)),
                  searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)))),
                  popupShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  mode: Mode.MENU,
                  items: categoriesOne,
                  filterFn: (model, filter) {
                    return model!.categoryName.contains(filter ?? '');
                  },
                  hint: S.current.chooseCategory,
                  //         popupItemDisabled: (String s) => s.startsWith('I'),
                  itemAsString: (model) =>
                      model?.categoryName ?? S.current.unknown,
                  onChanged: (v) {
                    v as ProductsCategoryModel;
                    screenState.idOne = v;
                    screenState.idTwo = null;
                    screenState.getStoreCategoriesLevelTwo(categoriesOne, v.id);
                  },
                  selectedItem: screenState.idOne),
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
              child: DropdownSearch<ProductsCategoryModel>(
                  enabled: categoriesTwo.isNotEmpty,
                  showSearchBox: true,
                  dropdownBuilder: (context, model) {
                    if (model == null) {
                      return Text(
                        S.current.chooseCategory,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: categoriesTwo.isEmpty
                                ? Theme.of(context).disabledColor
                                : null),
                      );
                    }
                    return Text(
                      model.categoryName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                  dropdownSearchDecoration: InputDecoration(
                      hintText: S.current.chooseCategory,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).disabledColor),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0)),
                  searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)))),
                  popupShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  mode: Mode.MENU,
                  items: categoriesTwo,
                  filterFn: (model, filter) {
                    return model!.categoryName.contains(filter ?? '');
                  },
                  //         popupItemDisabled: (String s) => s.startsWith('I'),
                  itemAsString: (model) =>
                      model?.categoryName ?? S.current.unknown,
                  onChanged: (v) {
                    v as ProductsCategoryModel;
//                    idTwo = v;
                    screenState.idTwo = v;
                    screenState.getStoreProductLevelTwo(
                        categoriesOne, categoriesTwo, v.id);
                  },
                  selectedItem: screenState.idTwo),
            ),
          ),
        ),
        Expanded(
          child: CustomListView.custom(children: getProducts()),
        ),
        ElevatedButton(
          onPressed: () {
            if (screenState.idOne != null) {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AddProductsForm(
                      lang: screenState.language,
                      state: this,
                      languages: ['ar', 'en', 'urdu'],
                      addProduct:
                          (name, image, price, discount, quantity, trans) {
                        Navigator.of(context).pop();
                        screenState.createProduct(
                            CreateProductRequest(
                                dataStoreProduct: DataStoreProduct(
                                  productName: name,
                                  productImage: image,
                                  productPrice: price,
                                  discount: discount,
                                  productQuantity: quantity,
                                  storeProductCategoryID:
                                      screenState.idTwo != null
                                          ? screenState.idTwo?.id
                                          : screenState.idOne?.id,
                                ),
                                translate: trans),
                            categoriesOne,
                            categoriesTwo,
                            screenState.idTwo?.id != null ? true : false);
                      },
                    );
                  });
            } else {
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: S.current.chooseCategory)
                ..show(screenState.context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              S.current.addProducts,
              style: TextStyle(color: Colors.white),
            ),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 3),
        ),
        SizedBox(
          height: 5,
        )
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
//      if (idTwo != null && idTwo != element.storeProductCategoryID.toString()) {
//        continue;
//      }
      widgets.add(Row(
        children: [
          Expanded(
              child: ProductComponent(
            discount: element.discount.toString(),
            description: '',
            status: element.status,
            image: element.productImage.image ?? '',
            rating: 0,
            title: element.productName,
            productId: element.id.toString(),
            price: element.productPrice.toString(),
                quantity: element.productQuantity.toString(),
          )),
          Column(
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                      context: screenState.context,
                      builder: (context) {
                        return UpdateProductsForm(
                          categoriesService:
                              screenState.widget.categoriesService,
                          request: UpdateProductRequest(
                            dataStoreProduct: DataStoreUpdateProduct(
                                productName: element.productName,
                                productImage: element.productImage.image ?? '',
                                productPrice: element.productPrice.toDouble(),
                                discount: element.discount,
                                productQuantity: element.productQuantity,
                                storeProductCategoryID:
                                    element.storeProductCategoryID,
                                storeMainCategoryID: screenState.idOne?.id,
                                categoryName: screenState.idOne?.id,
                                isLevelOne: element.levelOne,
                                isLevelTwo: element.levelTwo
                                ,productStatus: element.status),
                          ),
                          categoriesOne: getChoicesOne(),
                          categoriesTwo: getChoicesTwo(),
                          categoryLink: element.categoryLink ?? CategoryLink(),
                          addProduct: (name, price, image, discount, catID,q,status) {
                            Navigator.of(context).pop();
                            screenState.updateProduct(
                              UpdateProductRequest(
                                  dataStoreProduct: DataStoreUpdateProduct(
                                      id: element.id,
                                      productName: name,
                                      productImage: image,
                                      productQuantity: q,
                                      discount: double.parse(discount),
                                      productPrice: double.parse(price),
                                      storeProductCategoryID: int.parse(catID),
                                      isLevelOne: element.levelOne,
                                      isLevelTwo: element.levelTwo,productStatus: status)),
                              categoriesOne,
                              categoriesTwo,
                              screenState.idTwo != null ? true : false,
                            );
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
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  screenState.deleteProduct(
                    element.id.toString(),
                    categoriesOne,
                    categoriesTwo,
                  );
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
      ));
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
      widgets.add(CategoryCard(
        title: element.categoryName,
        id: element.id,
        selected: false,
        onTap: (id) {},
      ));
    }
    return widgets;
  }
}

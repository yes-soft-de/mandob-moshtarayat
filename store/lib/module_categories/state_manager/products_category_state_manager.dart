import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/service/store_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/product_categories_screen.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_loaded_state.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_loading_state.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_category/product_categories_state.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class ProductsCategoryStateManager {
  final CategoriesService _categoriesService;

  final AuthService _authService;

  final ImageUploadService _uploadService;
  final StoresService _storesService;

  final PublishSubject<ProductCategoriesState> _stateSubject = PublishSubject();

  Stream<ProductCategoriesState> get stateStream => _stateSubject.stream;

  ProductsCategoryStateManager(
      this._categoriesService, this._authService, this._uploadService, this._storesService);

  void getCategoryLevelOne(ProductCategoriesScreenState screenState) {

    _stateSubject.add(ProductCategoriesLoadingState(screenState));
    if(_authService.isLoggedIn){
      print('tfff');
    _storesService.getStoreProfile().then((value){
    if (value.hasError) {
        _stateSubject.add(
        ProductCategoriesLoadedState(screenState, [],[],[], -1,error: value.error));
    } else if (value.isEmpty) {
    _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
    empty: value.isEmpty));
    } else {
      StoreProfileModel model = value as StoreProfileModel;
      print('cate id');
      print(model.storeCategoryId);
      _categoriesService.getCategoryLevelOne(model.data.storeCategoryId).then((value) {
        if (value.hasError) {
          _stateSubject.add(
              ProductCategoriesLoadedState(screenState, [],[],[], -1,error: value.error));
        } else if (value.isEmpty) {
          _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
              empty: value.isEmpty));
        } else {
          ProductsCategoryModel model = value as ProductsCategoryModel;
          _stateSubject.add(ProductCategoriesLoadedState(screenState, model.data,[],[],-1));
        }
      });
    }
    });
    }else{
      print('tfffError');
      _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,error: S.current.pleaseLoginToContinue,));
    }

  }


  void getCategoryLevelTwo(ProductCategoriesScreenState screenState,List<ProductsCategoryModel> levelOne,int id,String levelOneName) {

//    _stateSubject.add(ProductCategoriesLoadingState(screenState));

    _categoriesService.getCategoryLevelTwo(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            ProductCategoriesLoadedState(screenState, [],[],[],-1, error: value.error));
      } else if (value.isEmpty) {
        getStoreProductLevelOne(screenState,levelOne,[],id,levelOneName);
//        _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
//            empty: value.isEmpty));
      } else {
        ProductsCategoryModel model = value as ProductsCategoryModel;
        getStoreProductLevelOne(screenState,levelOne,model.data,id,levelOneName,);

//        _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,model.data,[],id,nameOne: levelOneName));
      }
    });

  }
  void getStoreProductLevelOne(ProductCategoriesScreenState screenState,List<ProductsCategoryModel> levelOne,List<ProductsCategoryModel> levelTwo,int id,String levelOneName){
    _categoriesService.getProductsLevelOne(id).then((products){
      if (products.hasError) {
        _stateSubject.add(
            ProductCategoriesLoadedState(screenState, [],[],[],-1, error: products.error));
      } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
        _stateSubject.add(ProductCategoriesLoadedState(screenState, levelOne,levelTwo,[],id,nameOne: levelOneName));      }
      else {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
        ProductsModel storeProducts = products as ProductsModel;
        _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,id,nameOne: levelOneName,idFirstCat: id));
      }
    });
  }


  void getStoreProductLevelTwo(ProductCategoriesScreenState screenState,List<ProductsCategoryModel> levelOne,List<ProductsCategoryModel> levelTwo,int id,String levelOneName ,String levelTwoName){
    _categoriesService.getProductsLevelTwo(id).then((products){
      if (products.hasError) {
        _stateSubject.add(
            ProductCategoriesLoadedState(screenState, [],[],[],-1, error: products.error));
      } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
        _stateSubject.add(ProductCategoriesLoadedState(screenState, levelOne,levelTwo,[],id,nameOne: levelOneName,nameTwo: levelTwoName));      }
      else {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
        ProductsModel storeProducts = products as ProductsModel;
        _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,id,nameOne: levelOneName,nameTwo: levelTwoName));
      }
    });
  }


  void updateProduct(
      ProductCategoriesScreenState screenState,UpdateProductRequest request,List<ProductsCategoryModel> levelOne,List<ProductsCategoryModel> levelTwo,{String? nameOne  ,String? nameTwo}) {
    _stateSubject.add(ProductCategoriesLoadingState(screenState));
    if (!request.dataStoreProduct!.productImage!.contains('/original-image/')){
      _uploadService.uploadImage(request.dataStoreProduct?.productImage ?? '').then((value){
        if (value == null){
          getStoreProductLevelTwo(screenState,levelOne,levelTwo,request.dataStoreProduct?.storeProductCategoryID??-1,'','');
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: S.current.errorUploadingImages)
            ..show(screenState.context);
        }
        else {
          request.dataStoreProduct?.productImage = value;
          _categoriesService.updateProduct(request).then((value) {
            if (value.hasError) {
              getStoreProductLevelTwo(screenState,levelOne,levelTwo,request.dataStoreProduct?.storeProductCategoryID??-1,'','');
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
                ..show(screenState.context);
            } else {
              if(nameTwo != null){
                _categoriesService.getProductsLevelTwo(request.dataStoreProduct?.storeProductCategoryID??-1).then((products){
                  if (products.hasError) {
                    _stateSubject.add(
                        ProductCategoriesLoadedState(screenState, [],[],[],-1, error: products.error));
                  } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                    _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
                        empty: products.isEmpty));      }
                  else {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                    ProductsModel storeProducts = products as ProductsModel;
                    _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,request.dataStoreProduct?.storeProductCategoryID??-1,nameOne: nameOne,nameTwo:nameTwo ));
                  }
                });
              }else{
                _categoriesService.getProductsLevelOne(request.dataStoreProduct?.storeMainCategoryID??-1).then((products){
                  if (products.hasError) {
                    _stateSubject.add(
                        ProductCategoriesLoadedState(screenState, [],[],[],-1, error: products.error));
                  } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                    _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
                        empty: products.isEmpty));      }
                  else {
                    print('levelOneproduct');
                    print(nameOne);
                    ProductsModel storeProducts = products as ProductsModel;
                    _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,request.dataStoreProduct?.storeProductCategoryID??-1,nameOne: nameOne,nameTwo:nameTwo ,idFirstCat: request.dataStoreProduct?.storeMainCategoryID));
                  }
                });
              }
              CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.updateProduct)
                ..show(screenState.context);
            }
          });
        }
      });
    }
    else {
      _categoriesService.updateProduct(request).then((value) {
        if (value.hasError) {
          print('bssst');
          getStoreProductLevelTwo(screenState,levelOne,levelTwo,request.dataStoreProduct?.storeProductCategoryID??-1,'','');
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          if(nameTwo != null){
            _categoriesService.getProductsLevelTwo(request.dataStoreProduct?.storeProductCategoryID??-1).then((products){
              if (products.hasError) {
                _stateSubject.add(
                    ProductCategoriesLoadedState(screenState, [],[],[],-1, error: products.error));
              } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
                    empty: products.isEmpty));      }
              else {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                ProductsModel storeProducts = products as ProductsModel;
                _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,request.dataStoreProduct?.storeProductCategoryID??-1,nameOne: nameOne,nameTwo:nameTwo ));
              }
            });
          }else{
            _categoriesService.getProductsLevelOne(request.dataStoreProduct?.storeMainCategoryID??-1).then((products){
              if (products.hasError) {
                _stateSubject.add(
                    ProductCategoriesLoadedState(screenState, [],[],[],-1, error: products.error));
              } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
                    empty: products.isEmpty));      }
              else {
                print('levelOneproduct');
                print(nameOne);
                ProductsModel storeProducts = products as ProductsModel;
                print('hfff');
                print( request.dataStoreProduct?.storeMainCategoryID.toString()??'');
                _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,request.dataStoreProduct?.storeProductCategoryID??-1,nameOne: nameOne,nameTwo:nameTwo,idFirstCat: request.dataStoreProduct?.storeMainCategoryID));
              }
            });
          }
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.updateProduct)
            ..show(screenState.context);
        }
      });
    }
  }


  void createProduct(
      ProductCategoriesScreenState screenState,CreateProductRequest request,List<ProductsCategoryModel> levelOne,List<ProductsCategoryModel> levelTwo , {String? nameOne  ,String? nameTwo}) {
    _stateSubject.add(ProductCategoriesLoadingState(screenState));
    _uploadService.uploadImage(request.dataStoreProduct?.productImage ?? '').then((value){
      if (value == null){
//        getProductCategory(screenState,request.storeOwnerProfileID ?? -1);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.errorUploadingImages)
          ..show(screenState.context);
      }
      else {
        request.dataStoreProduct?.productImage = value;
        print('teesst');
        print(value);
        _categoriesService.createProduct(request).then((value) {
          if (value.hasError) {
//            getProductCategory(screenState,request.storeOwnerProfileID ?? -1);
            CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
              ..show(screenState.context);
          } else {
            if(nameTwo != null){
              _categoriesService.getProductsLevelTwo(request.dataStoreProduct?.storeProductCategoryID??-1).then((products){
                if (products.hasError) {
                  _stateSubject.add(
                      ProductCategoriesLoadedState(screenState, [],[],[],-1, error: products.error));
                } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                  _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
                      empty: products.isEmpty));      }
                else {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                  ProductsModel storeProducts = products as ProductsModel;
                  _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,request.dataStoreProduct?.storeProductCategoryID??-1,nameOne: nameOne,nameTwo:nameTwo ));
                }
              });
            }else{
              _categoriesService.getProductsLevelOne(request.dataStoreProduct?.storeProductCategoryID??-1).then((products){
                if (products.hasError) {
                  _stateSubject.add(
                      ProductCategoriesLoadedState(screenState, [],[],[],-1, error: products.error));
                } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                  _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
                      empty: products.isEmpty));      }
                else {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                  ProductsModel storeProducts = products as ProductsModel;
                  _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,request.dataStoreProduct?.storeProductCategoryID??-1,nameOne: nameOne,nameTwo:nameTwo ));
                }
              });
            }


            CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.productCreatedSuccessfully)
              ..show(screenState.context);
          }
        });
      }
    });
  }
  void updateProductStatus(
      ProductCategoriesScreenState screenState,UpdateProductStatusRequest request,List<ProductsCategoryModel> levelOne,List<ProductsCategoryModel> levelTwo,{String? nameOne  ,String? nameTwo}) {
    _stateSubject.add(ProductCategoriesLoadingState(screenState));
      _categoriesService.updateProductStatus(request).then((value) {
        if (value.hasError) {
          print('bssst');
          getStoreProductLevelTwo(screenState,levelOne,levelTwo,request.storeProductCategoryID,'','');
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          if(nameTwo != null){
            _categoriesService.getProductsLevelTwo(request.storeProductCategoryID).then((products){
              if (products.hasError) {
                _stateSubject.add(
                    ProductCategoriesLoadedState(screenState, [],[],[],-1, error: products.error));
              } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
                    empty: products.isEmpty));      }
              else {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                ProductsModel storeProducts = products as ProductsModel;
                _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,request.storeProductCategoryID,nameOne: nameOne,nameTwo:nameTwo ));
              }
            });
          }else{
            _categoriesService.getProductsLevelOne(request.storeMainCategoryID).then((products){
              if (products.hasError) {
                _stateSubject.add(
                    ProductCategoriesLoadedState(screenState, [],[],[],-1, error: products.error));
              } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                _stateSubject.add(ProductCategoriesLoadedState(screenState, [],[],[],-1,
                    empty: products.isEmpty));      }
              else {
                print('levelOneproduct');
                print(nameOne);
                ProductsModel storeProducts = products as ProductsModel;
                _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,request.storeProductCategoryID,nameOne: nameOne,nameTwo:nameTwo ,idFirstCat: request.storeMainCategoryID));
              }
            });
          }
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.deleteSuccess)
            ..show(screenState.context);
        }
      });
    }

  Future<List<ProductsCategoryModel>?> getLevelTwo(int id) async {

   await _categoriesService.getCategoryLevelTwo(id).then((value) {
      if (value.hasError) {
       return ProductsCategoryModel(id: -1,categoryName: '');
      } else if (value.isEmpty) {
        return ProductsCategoryModel(id: -1,categoryName: '');
      } else {
        print('fuk');
        ProductsCategoryModel model = value as ProductsCategoryModel;
        print(model.data.length);
        return model.data;
      }
    });

  }

}

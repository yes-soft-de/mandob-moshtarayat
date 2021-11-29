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

  void getProductsCategoryLevelOne(ProductCategoriesScreenState screenState) {

    _stateSubject.add(ProductCategoriesLoadingState(screenState));
    if(_authService.isLoggedIn){
      print('tfff');
    _storesService.getStoreProfile().then((value){
    if (value.hasError) {
        _stateSubject.add(
        ProductCategoriesLoadedState(screenState, null,null,null, -1,error: value.error));
    } else if (value.isEmpty) {
    _stateSubject.add(ProductCategoriesLoadedState(screenState, null,null,null,-1,
    empty: value.isEmpty));
    } else {
      StoreProfileModel model = value as StoreProfileModel;
      print('cate id');
      print(model.storeCategoryId);
      _categoriesService.getProductsCategoryLevelOne(model.data.storeCategoryId).then((value) {
        if (value.hasError) {
          _stateSubject.add(
              ProductCategoriesLoadedState(screenState, null,null,null, -1,error: value.error));
        } else if (value.isEmpty) {
          _stateSubject.add(ProductCategoriesLoadedState(screenState, null,null,null,-1,
              empty: value.isEmpty));
        } else {
          ProductsCategoryModel model = value as ProductsCategoryModel;
          _stateSubject.add(ProductCategoriesLoadedState(screenState, model.data,null,null,-1));
        }
      });
    }
    });
    }else{
      print('tfffError');
      _stateSubject.add(ProductCategoriesLoadedState(screenState, null,null,null,-1,error: S.current.pleaseLoginToContinue,));
    }

  }
  void getProductsCategoryLevelTwo(ProductCategoriesScreenState screenState,List<ProductsCategoryModel> levelOne,int id,String levelOneName) {

    _stateSubject.add(ProductCategoriesLoadingState(screenState));

    _categoriesService.getProductsCategoryLevelTwo(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            ProductCategoriesLoadedState(screenState, null,null,null,-1, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(ProductCategoriesLoadedState(screenState, null,null,null,-1,
            empty: value.isEmpty));
      } else {
        ProductsCategoryModel model = value as ProductsCategoryModel;
        _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,model.data,null,id,nameOne: levelOneName));
      }
    });

  }


  void getStoreProduct(ProductCategoriesScreenState screenState,List<ProductsCategoryModel> levelOne,List<ProductsCategoryModel> levelTwo,int id,String levelOneName ,String levelTwoName){
    _categoriesService.getProducts(id).then((products){
      if (products.hasError) {
        _stateSubject.add(
            ProductCategoriesLoadedState(screenState, null,null,null,-1, error: products.error));
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
      ProductCategoriesScreenState screenState,UpdateProductRequest request,List<ProductsCategoryModel> levelOne,List<ProductsCategoryModel> levelTwo) {
    _stateSubject.add(ProductCategoriesLoadingState(screenState));
    if (!request.productImage!.contains('/original-image/')){
      _uploadService.uploadImage(request.productImage ?? '').then((value){
        if (value == null){
          getStoreProduct(screenState,levelOne,levelTwo,request.storeProductCategoryID??-1,'','');
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: S.current.errorUploadingImages)
            ..show(screenState.context);
        }
        else {
          request.productImage = value;
          _categoriesService.updateProduct(request).then((value) {
            if (value.hasError) {
              getStoreProduct(screenState,levelOne,levelTwo,request.storeProductCategoryID??-1,'','');
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
                ..show(screenState.context);
            } else {
              getStoreProduct(screenState,levelOne,levelTwo,request.storeProductCategoryID??-1,'','');
              CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.categoryCreatedSuccessfully)
                ..show(screenState.context);
            }
          });
        }
      });
    }
    else {
      print('NotUpload');
      print(request.productImage);
      _categoriesService.updateProduct(request).then((value) {
        if (value.hasError) {
          print('bssst');
          getStoreProduct(screenState,levelOne,levelTwo,request.storeProductCategoryID??-1,'','');
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getStoreProduct(screenState,levelOne,levelTwo,request.storeProductCategoryID??-1,'','');
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.updateProduct)
            ..show(screenState.context);
        }
      });
    }
  }


  void createProduct(
      ProductCategoriesScreenState screenState,CreateProductRequest request,List<ProductsCategoryModel> levelOne,List<ProductsCategoryModel> levelTwo) {
    _stateSubject.add(ProductCategoriesLoadingState(screenState));
    _uploadService.uploadImage(request.productImage ?? '').then((value){
      if (value == null){
//        getProductCategory(screenState,request.storeOwnerProfileID ?? -1);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.errorUploadingImages)
          ..show(screenState.context);
      }
      else {
        request.productImage = value;
        print('teesst');
        print(value);
        _categoriesService.createProduct(request).then((value) {
          if (value.hasError) {
//            getProductCategory(screenState,request.storeOwnerProfileID ?? -1);
            CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
              ..show(screenState.context);
          } else {
            _categoriesService.getProducts(request.storeProductCategoryID??-1).then((products){
              if (products.hasError) {
                _stateSubject.add(
                    ProductCategoriesLoadedState(screenState, null,null,null,-1, error: products.error));
              } else if (products.isEmpty) {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                _stateSubject.add(ProductCategoriesLoadedState(screenState, null,null,null,-1,
                    empty: products.isEmpty));      }
              else {
//        ProductsCategoryModel model = value as ProductsCategoryModel;
                ProductsModel storeProducts = products as ProductsModel;
                _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,levelTwo,storeProducts.data,request.storeProductCategoryID??-1));
              }
            });
            CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.productCreatedSuccessfully)
              ..show(screenState.context);
          }
        });
      }
    });
  }
}

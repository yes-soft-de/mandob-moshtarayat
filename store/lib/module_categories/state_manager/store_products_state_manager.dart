import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/service/store_service.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_store/product_store_state.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';

@injectable
class StoreProductsStateManager {
  final CategoriesService _categoriesService;
  final StoresService _storesService;
  final AuthService _authService;
  final ImageUploadService _uploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreProductsStateManager(
      this._categoriesService, this._authService, this._storesService, this._uploadService);

  void getStoreProducts(StoreProductScreenState screenState,String name,{List<ProductsCategoryModel>? catOne ,List<ProductsCategoryModel>? catTwo}) {
    if (_authService.isLoggedIn) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getStoreProducts(name).then((products) {
      if (products.hasError) {
        _stateSubject.add(
            ProductStoreState(screenState, null,null,null, error: products.error));
      } else if (products.isEmpty) {
        _stateSubject.add(ProductStoreState(screenState, [],[],[]));
      }
      else {
        ProductsModel storeProducts = products as ProductsModel;
        _stateSubject.add(ProductStoreState(screenState, storeProducts.data,catOne,catTwo));
      }
    });
  }else{
      screenState.goToLogin();
    }
      }
  void getCategoriesLevelOne(StoreProductScreenState screenState,String name){
    if(_authService.isLoggedIn){
      print('tfff');
      _storesService.getStoreProfile().then((value){
        if (value.hasError) {
          _stateSubject.add(
              ProductStoreState(screenState, null,null,null,error: value.error));
        } else if (value.isEmpty) {
          _stateSubject.add(ProductStoreState(screenState, [],[],[],
              empty: value.isEmpty));
        } else {
          StoreProfileModel model = value as StoreProfileModel;
          _categoriesService.getCategoryLevelOne().then((value) {
            if (value.hasError) {
              _stateSubject.add(
                  ProductStoreState(screenState, null,null,null,error: value.error));
            } else if (value.isEmpty) {
              _stateSubject.add(ProductStoreState(screenState, [],[],[],
                  empty: value.isEmpty));
            } else {
              ProductsCategoryModel categoryModel = value as ProductsCategoryModel;
              _stateSubject.add(ProductStoreState(screenState,[],categoryModel.data,[]));
            }
          });
        }
      });
    }else{
      print('tfffError');
      screenState.goToLogin();   }
  }

 void getCategoriesLevelOneWithAllProducts(StoreProductScreenState screenState,String name){
   if(_authService.isLoggedIn){
     print('tfff');
     _storesService.getStoreProfile().then((value){
       if (value.hasError) {
         _stateSubject.add(
             ProductStoreState(screenState, null,null,null,error: value.error));
       } else if (value.isEmpty) {
         _stateSubject.add(ProductStoreState(screenState, [],[],[],
             empty: value.isEmpty));
       } else {
         StoreProfileModel model = value as StoreProfileModel;
         print(model.storeCategoryId);
         _categoriesService.getCategoryLevelOne().then((value) {
           if (value.hasError) {
             _stateSubject.add(
                 ProductStoreState(screenState, null,null,null,error: value.error));
           } else if (value.isEmpty) {
             _stateSubject.add(ProductStoreState(screenState, [],[],[],
                 empty: value.isEmpty));
           } else {
             ProductsCategoryModel categoryModel = value as ProductsCategoryModel;
             getStoreProducts(screenState,name,catOne: categoryModel.data,catTwo: []);
//             _stateSubject.add(ProductCategoriesLoadedState(screenState, model.data,[],[],-1));
           }
         });
       }
     });
   }else{
     print('tfffError');
     screenState.goToLogin();   }
 }

  void getCategoriesLevelTwoWithProducts(StoreProductScreenState screenState,int storeCategoryId,List<ProductsCategoryModel>? catOne){
    if(_authService.isLoggedIn){
      _categoriesService.getCategoryLevelTwo(storeCategoryId).then((value) {
        if (value.hasError) {
          _stateSubject.add(
              ProductStoreState(screenState, null,null,null,error: value.error));
        } else if (value.isEmpty) {
          getStoreProductLevelOne(screenState,storeCategoryId,catOne: catOne,catTwo: []);
        } else {
          ProductsCategoryModel categoryModel = value as ProductsCategoryModel;
          getStoreProductLevelOne(screenState,storeCategoryId,catOne: catOne,catTwo: categoryModel.data);
        }
      });
    }else{
      screenState.goToLogin();   }
  }


  void getStoreProductLevelOne(StoreProductScreenState screenState, int id,{List<ProductsCategoryModel>? catOne ,List<ProductsCategoryModel>? catTwo}){
    _categoriesService.getProductsLevelOne(id).then((products){
      if (products.hasError) {
        _stateSubject.add(
            ProductStoreState(screenState, [],[],[], error: products.error));
      } else if (products.isEmpty) {
        _stateSubject.add(ProductStoreState(screenState,[],catOne,catTwo,idOne: id,));      }
      else {
        ProductsModel storeProducts = products as ProductsModel;
        _stateSubject.add(ProductStoreState(screenState,storeProducts.data ,catOne,catTwo,idOne: id,));
      }
    });
  }


  void getStoreProductLevelTwo(StoreProductScreenState screenState, int idSub,{int? idMain,List<ProductsCategoryModel>? catOne ,List<ProductsCategoryModel>? catTwo}){
    _categoriesService.getProductsLevelTwo(idSub).then((products){
      if (products.hasError) {
        _stateSubject.add(
            ProductStoreState(screenState, [],[],[], error: products.error));
      } else if (products.isEmpty) {
        _stateSubject.add(ProductStoreState(screenState,[],catOne,catTwo,idOne: idMain,idTwo:idSub ));      }
      else {
        ProductsModel storeProducts = products as ProductsModel;
        _stateSubject.add(ProductStoreState(screenState,storeProducts.data ,catOne,catTwo,idOne: idMain,idTwo:idSub ));
      }
    });
  }

  void updateProduct(UpdateProductRequest request , StoreProductScreenState screenState,List<ProductsCategoryModel>? levelOne){
    _stateSubject.add(LoadingState(screenState));
    if (!request.dataStoreProduct!.productImage!.contains('/original-image/')){
      _uploadService.uploadImage(request.dataStoreProduct?.productImage ?? '').then((value){
        if (value == null){
          getStoreProducts(screenState,'',catOne:levelOne,catTwo: []);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: S.current.errorUploadingImages)
            ..show(screenState.context);
        }
        else {
          request.dataStoreProduct?.productImage = value;
          _categoriesService.updateProduct(request).then((value) {
            if (value.hasError) {
              getStoreProducts(screenState,'',catOne: levelOne);
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
                ..show(screenState.context);
            } else {
              getStoreProducts(screenState, '', catOne: levelOne);
              CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.updateProduct)
                ..show(screenState.context);
            }});
        }
      });
    }else {
      _categoriesService.updateProduct(request).then((value) {
        if (value.hasError) {
          getStoreProducts(screenState,'',catOne: levelOne,catTwo: []);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getStoreProducts(screenState, '', catOne: levelOne,catTwo: []);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.updateProduct)
            ..show(screenState.context);
        }});
    }
  }
  void updateProductStatus(
      UpdateProductStatusRequest request,  StoreProductScreenState screenState,List<ProductsCategoryModel> levelOne) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.updateProductStatus(request).then((value) {
      if (value.hasError) {
        print('bssst');
        getStoreProducts(screenState,'',catOne:levelOne,catTwo: []);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        getStoreProducts(screenState,'',catOne:levelOne,catTwo: []);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.deleteSuccess)
          ..show(screenState.context);
      }
    });
  }
}

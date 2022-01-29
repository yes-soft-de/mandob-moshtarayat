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

  ProductsCategoryStateManager(this._categoriesService, this._authService,
      this._uploadService, this._storesService);

  void getCategoryLevelOne(ProductCategoriesScreenState screenState) {
    _stateSubject.add(ProductCategoriesLoadingState(screenState));
    if (_authService.isLoggedIn) {
      _categoriesService.getCategoryLevelOne().then((value) {
        if (value.hasError) {
          _stateSubject.add(ProductCategoriesLoadedState(
              screenState, [], [], [],
              error: value.error));
        } else if (value.isEmpty) {
          _stateSubject.add(ProductCategoriesLoadedState(
              screenState, [], [], [],
              empty: value.isEmpty));
        } else {
          ProductsCategoryModel model = value as ProductsCategoryModel;
          _stateSubject.add(ProductCategoriesLoadedState(
              screenState, model.data, [], []));
        }
      });
    } else {
      _stateSubject.add(ProductCategoriesLoadedState(
        screenState,
        [],
        [],
        [],
        error: S.current.pleaseLoginToContinue,
      ));
    }
  }

  void getCategoryLevelTwo(ProductCategoriesScreenState screenState,
      List<ProductsCategoryModel> levelOne, int id) {

    _categoriesService.getCategoryLevelTwo(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(ProductCategoriesLoadedState(
            screenState, [], [], [],
            error: value.error));
      } else if (value.isEmpty) {
        getStoreProductLevelOne(screenState, levelOne, [], id);
      } else {
        ProductsCategoryModel model = value as ProductsCategoryModel;
        getStoreProductLevelOne(
          screenState,
          levelOne,
          model.data,
          id,
        );
      }
    });
  }

  void getStoreProductLevelOne(
      ProductCategoriesScreenState screenState,
      List<ProductsCategoryModel> levelOne,
      List<ProductsCategoryModel> levelTwo,
      int id) {
    _categoriesService.getProductsLevelOne(id).then((products) {
      if (products.hasError) {
        _stateSubject.add(ProductCategoriesLoadedState(
            screenState, [], [], [],
            error: products.error));
      } else if (products.isEmpty) {
         _stateSubject.add(ProductCategoriesLoadedState(
            screenState, levelOne, levelTwo, []));
      } else {
        ProductsModel storeProducts = products as ProductsModel;
        _stateSubject.add(ProductCategoriesLoadedState(
            screenState, levelOne, levelTwo, storeProducts.data,));
      }
    });
  }

  void getStoreProductLevelTwo(
      ProductCategoriesScreenState screenState,
      List<ProductsCategoryModel> levelOne,
      List<ProductsCategoryModel> levelTwo,
      int id) {
    _categoriesService.getProductsLevelTwo(id).then((products) {
      if (products.hasError) {
        _stateSubject.add(ProductCategoriesLoadedState(
            screenState, [], [], [],
            error: products.error));
      } else if (products.isEmpty) {
        _stateSubject.add(ProductCategoriesLoadedState(
            screenState, levelOne, levelTwo, []));
      } else {
        ProductsModel storeProducts = products as ProductsModel;
        _stateSubject.add(ProductCategoriesLoadedState(
            screenState, levelOne, levelTwo, storeProducts.data));
      }
    });
  }

  void updateProduct(
      ProductCategoriesScreenState screenState,
      UpdateProductRequest request,
      List<ProductsCategoryModel> levelOne,
      List<ProductsCategoryModel> levelTwo,bool isLevelTwo, int id) {
    _stateSubject.add(ProductCategoriesLoadingState(screenState));
    if (!request.dataStoreProduct.productImage!.contains('/original-image/')) {
      _uploadService
          .uploadImage(request.dataStoreProduct.productImage ?? '')
          .then((value) {
        if (value == null) {
          _stateSubject.add(ProductCategoriesLoadedState(
              screenState, levelOne, [], []));
          CustomFlushBarHelper.createError(
              title: S.current.warnning,
              message: S.current.errorUploadingImages)
            ..show(screenState.context);
        } else {
          request.dataStoreProduct.productImage = value;
          _categoriesService.updateProduct(request).then((value) {
            if (value.hasError) {
              _stateSubject.add(ProductCategoriesLoadedState(
                  screenState, levelOne, [], []));
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
                ..show(screenState.context);
            } else {
              getProductsLevelOneOrTow(screenState ,levelOne ,levelTwo , id,isLevelTwo);
              CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning, message: S.current.updateProduct)
                ..show(screenState.context);
            }
          });
        }
      });
    } else {
      _categoriesService.updateProduct(request).then((value) {
        if (value.hasError) {
          _stateSubject.add(ProductCategoriesLoadedState(
              screenState, levelOne, [], []));
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getProductsLevelOneOrTow(screenState ,levelOne ,levelTwo , id,isLevelTwo);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning, message: S.current.updateProduct)
            ..show(screenState.context);
        }
      });
    }
  }
//
  void createProduct(
      ProductCategoriesScreenState screenState,
      CreateProductRequest request,
      List<ProductsCategoryModel> levelOne,
      List<ProductsCategoryModel> levelTwo,bool isLevelTwo ) {
    _stateSubject.add(ProductCategoriesLoadingState(screenState));
    _uploadService
        .uploadImage(request.dataStoreProduct?.productImage ?? '')
        .then((value) {
      if (value == null) {
        _stateSubject.add(ProductCategoriesLoadedState(
            screenState, levelOne, [], []));
         CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.errorUploadingImages)
          ..show(screenState.context);
      } else {
        request.dataStoreProduct?.productImage = value;
        _categoriesService.createProduct(request).then((value) {
          if (value.hasError) {
            _stateSubject.add(ProductCategoriesLoadedState(
                screenState, levelOne, [], []));
            CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
              ..show(screenState.context);
          } else {
            getProductsLevelOneOrTow(screenState ,levelOne ,levelTwo , request.dataStoreProduct?.storeProductCategoryID??-1,isLevelTwo);
            CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.productCreatedSuccessfully)
              ..show(screenState.context);
          }
        });
      }
    });
  }
  getProductsLevelOneOrTow(ProductCategoriesScreenState screenState,
      List<ProductsCategoryModel> levelOne,
      List<ProductsCategoryModel> levelTwo, int id,bool isLevelTwo){
    if(isLevelTwo){
      getStoreProductLevelTwo(screenState, levelOne, levelTwo, id);
    }else{
      getStoreProductLevelOne(screenState, levelOne, levelTwo,id);
    }
  }
//
  void deleteProduct(
      ProductCategoriesScreenState screenState,
      String request,
      List<ProductsCategoryModel> levelOne) {
    _stateSubject.add(ProductCategoriesLoadingState(screenState));
    _categoriesService.deleteProduct(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ProductCategoriesLoadedState(
            screenState,
            levelOne,
            [],
            []));
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        _stateSubject.add(ProductCategoriesLoadedState(
            screenState,
            levelOne,
            [],
            []));
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.deleteSuccess)
          ..show(screenState.context);
      }
    });
  }
}

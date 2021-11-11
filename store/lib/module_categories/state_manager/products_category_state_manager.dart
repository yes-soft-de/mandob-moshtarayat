import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_products_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_category_request.dart';
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

  final PublishSubject<ProductCategoriesState> _stateSubject = PublishSubject();

  Stream<ProductCategoriesState> get stateStream => _stateSubject.stream;

  ProductsCategoryStateManager(
      this._categoriesService, this._authService, this._uploadService);

  void getProductsCategoryLevelOne(ProductCategoriesScreenState screenState,int id) {

    _stateSubject.add(ProductCategoriesLoadingState(screenState));

    _categoriesService.getProductsCategoryLevelOne(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            ProductCategoriesLoadedState(screenState, null,null,null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(ProductCategoriesLoadedState(screenState, null,null,null,
            empty: value.isEmpty));
      } else {
        ProductsCategoryModel model = value as ProductsCategoryModel;
        _stateSubject.add(ProductCategoriesLoadedState(screenState, model.data,null,null));
      }
    });

  }
  void getProductsCategoryLevelTwo(ProductCategoriesScreenState screenState,List<ProductsCategoryModel> levelOne,int id) {

    _stateSubject.add(ProductCategoriesLoadingState(screenState));

    _categoriesService.getProductsCategoryLevelTwo(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            ProductCategoriesLoadedState(screenState, null,null,null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(ProductCategoriesLoadedState(screenState, null,null,null,
            empty: value.isEmpty));
      } else {
        ProductsCategoryModel model = value as ProductsCategoryModel;
        _stateSubject.add(ProductCategoriesLoadedState(screenState,levelOne ,model.data,null));
      }
    });

  }

  // void createProductCategory(
  //     ProductCategoriesScreenState screenState, CreateProductsCategoriesRequest request) {
  //   _stateSubject.add(ProductCategoriesLoadingState(screenState));
  //
  //   _categoriesService.createProductCategories(request).then((value) {
  //     if (value.hasError) {
  //       getProductCategory(screenState,request.storeOwnerProfileId??-1);
  //       CustomFlushBarHelper.createError(
  //           title: S.current.warnning, message: value.error ?? '')
  //         ..show(screenState.context);
  //     } else {
  //       getProductCategory(screenState,request.storeOwnerProfileId??-1);
  //       CustomFlushBarHelper.createSuccess(
  //           title: S.current.warnning,
  //           message: S.current.categoryCreatedSuccessfully)
  //         ..show(screenState.context);
  //     }
  //   });
  // }

  // void updateProductCategory(ProductCategoriesScreenState screenState, UpdateProductCategoryRequest request, int storeId) {
  //
  //   _stateSubject.add(ProductCategoriesLoadingState(screenState));
  //
  //   _categoriesService.updateProductCategory(request).then((value) {
  //     if (value.hasError) {
  //       getProductCategory(screenState,storeId);
  //       CustomFlushBarHelper.createError(
  //           title: S.current.warnning, message: value.error ?? '')
  //         ..show(screenState.context);
  //     } else {
  //       getProductCategory(screenState,storeId);
  //       CustomFlushBarHelper.createSuccess(
  //           title: S.current.warnning,
  //           message: S.current.categoryCreatedSuccessfully)
  //         ..show(screenState.context);
  //     }
  //   });
  // }

}

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/product_category_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/store_category_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_translation_product_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_translation_store_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/sub_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/update_categories_screen/update_level_two_category_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/update_categories_screen/update_store_category_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/update_categories_screen/update_sub_category_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/product_category/update_level_two_categories/update_level_two_categories_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/update_store_category_state/store_category_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/sub_categories/update_sub_categories/update_sub_categories_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class UpdateLevelTwoCategoriesStateManager {
  final CategoriesService _categoriesService;

  final AuthService _authService;
  final ImageUploadService _uploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  UpdateLevelTwoCategoriesStateManager(
      this._categoriesService, this._authService, this._uploadService);

  void getLevelTwoCategory(
      UpdateLevelTwoCategoryScreenState screenState, String id) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getProductCategory(id).then((value) {
      if (value.hasError) {
        _stateSubject
            .add(LevelTwoCategoryLoaded(screenState, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(LevelTwoCategoryLoaded(screenState, empty: value.isEmpty));
      } else {
        ProductCategoryModel model = value as ProductCategoryModel;
        screenState.model = model.data;
        _stateSubject.add(LevelTwoCategoryLoaded(screenState));
      }
    });
  }

  void updateCategory(UpdateLevelTwoCategoryScreenState screenState,
      SubCategoriesRequest request) {
    if (request.dataStoreCategory?.productCategoryImage
                ?.contains('/original-image/') ==
            true ||
        request.dataStoreCategory?.productCategoryImage == null) {
      _stateSubject.add(LoadingState(screenState));
      _categoriesService.updateSubCategories(request).then((value) {
        if (value.hasError) {
          _stateSubject
              .add(LevelTwoCategoryLoaded(screenState, error: value.error));
        } else {
          Navigator.of(screenState.context).pop(true);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning, message: S.current.updateStoreCategory)
            ..show(screenState.context);
        }
      });
    } else {
      _stateSubject.add(LoadingState(screenState));
      _uploadService
          .uploadImage(request.dataStoreCategory?.productCategoryImage)
          .then((value) {
        request.dataStoreCategory?.productCategoryImage = value;
        _categoriesService.updateSubCategories(request).then((value) {
          if (value.hasError) {
            _stateSubject
                .add(LevelTwoCategoryLoaded(screenState, error: value.error));
          } else {
            Navigator.of(screenState.context).pop(true);
            CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.updateStoreCategory)
              ..show(screenState.context);
          }
        });
      });
    }
  }

//
//
  void addNewTranslate(UpdateLevelTwoCategoryScreenState screenState,
      CreateNewTransProductCategoryRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.createNewTransProductCategory(request).then((value) {
      if (value.hasError) {
        _stateSubject
            .add(LevelTwoCategoryLoaded(screenState, error: value.error));
      } else {
        getLevelTwoCategory(
            screenState, request.storeProductCategoryID.toString());
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.updateStoreCategory)
          ..show(screenState.context);
      }
    });
  }
}

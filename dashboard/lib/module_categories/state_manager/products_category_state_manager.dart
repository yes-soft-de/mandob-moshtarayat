import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/category_level_tow_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/filter_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/level_tow_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/product_category/product_categories_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

@injectable
class ProductsCategoryStateManager {
  final CategoriesService _categoriesService;

  final AuthService _authService;

  final ImageUploadService _uploadService;

  final LocalizationService _localizationService;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  ProductsCategoryStateManager(this._categoriesService, this._authService,
      this._uploadService, this._localizationService);

  void getProductCategory(LevelTowCategoriesScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getStoreCategories().then((value) {
      if (value.hasError) {
        _stateSubject.add(ProductCategoriesLoadedState(screenState, null, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(ProductCategoriesLoadedState(screenState, null, null,
            empty: value.isEmpty));
      } else {
        StoreCategoriesModel model = value as StoreCategoriesModel;
        _stateSubject
            .add(ProductCategoriesLoadedState(screenState, null, model.data));
      }
    });
  }

  void getCategoriesLevelOne(LevelTowCategoriesScreenState screenState, int id,
      List<StoreCategoriesModel> model) {
    _categoriesService
        .getSubCategories(FilterLanguageAndCategoryRequest(
            storeCategoryID: id, language: _localizationService.getLanguage()))
        .then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else if (value.isEmpty) {
        _stateSubject
            .add(ProductCategoriesLoadedState(screenState, null, model));
      } else {
        SubCategoriesModel cats = value as SubCategoriesModel;
        _stateSubject
            .add(ProductCategoriesLoadedState(screenState, cats.data, model));
      }
    });
  }

  void getCategoriesLevelTow(
      LevelTowCategoriesScreenState screenState,
      FilterLanguageAndProductCategoryRequest id,
      List<StoreCategoriesModel> model,
      List<SubCategoriesModel> subCategories) {
    _categoriesService.getSubcategoriesLevelTow(id).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else if (value.isEmpty) {
        _stateSubject.add(
            ProductCategoriesLoadedState(screenState, subCategories, model));
      } else {
        SubCategoriesModel cats = value as SubCategoriesModel;
        _stateSubject.add(ProductCategoriesLoadedState(
            screenState, subCategories, model,
            subCategoriesLevelTow: cats.data));
      }
    });
  }

  void createProductCategory(LevelTowCategoriesScreenState screenState,
      CategoryLevelTowRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _uploadService
        .uploadImage(request.dataStoreCategory?.productCategoryImage)
        .then((value) {
      request.dataStoreCategory?.productCategoryImage = value;
      _categoriesService.createProductCategories(request).then((value) {
        if (value.hasError) {
          getProductCategory(screenState);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getProductCategory(screenState);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.categoryCreatedSuccessfully)
            ..show(screenState.context);
        }
      });
    });
  }

  void updateProductCategory(LevelTowCategoriesScreenState screenState,
      CategoryLevelTowRequest request) {
    _stateSubject.add(LoadingState(screenState));
    if (request.dataStoreCategory?.productCategoryImage
            ?.contains('/original-image/') ==
        true) {
      _categoriesService.updateProductCategory(request).then((value) {
        if (value.hasError) {
          getProductCategory(screenState);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getProductCategory(screenState);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.updateCategorySuccessfully)
            ..show(screenState.context);
        }
      });
    } else
      _uploadService
          .uploadImage(request.dataStoreCategory?.productCategoryImage)
          .then((value) {
        request.dataStoreCategory?.productCategoryImage = value;
        _categoriesService.updateProductCategory(request).then((value) {
          if (value.hasError) {
            getProductCategory(screenState);
            CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
              ..show(screenState.context);
          } else {
            getProductCategory(screenState);
            CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.updateCategorySuccessfully)
              ..show(screenState.context);
          }
        });
      });
  }

  void deleteSubCategories(
      LevelTowCategoriesScreenState screenState, String id) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.deleteSubCategories(id).then((value) {
      if (value.hasError) {
        getProductCategory(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getProductCategory(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.deleteSuccess)
            .show(screenState.context);
      }
    });
  }
}

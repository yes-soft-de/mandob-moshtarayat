import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/filter_category_request.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_store_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/store_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/store_categories_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/store_categories_loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/store_categories_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

@injectable
class StoreCategoriesStateManager {
  final CategoriesService _categoriesService;

  final AuthService _authService;
  final ImageUploadService _uploadService;
  final PublishSubject<StoreCategoriesState> _stateSubject = PublishSubject();

  Stream<StoreCategoriesState> get stateStream => _stateSubject.stream;

  StoreCategoriesStateManager(
      this._categoriesService, this._authService, this._uploadService);

  void getStoreCategories(StoreCategoriesScreenState screenState) {
    _stateSubject.add(StoreCategoriesLoadingState(screenState));
    _categoriesService.getStoreCategories().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            StoreCategoriesLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(StoreCategoriesLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        StoreCategoriesModel model = value as StoreCategoriesModel;
        _stateSubject.add(StoreCategoriesLoadedState(screenState, model.data));
      }
    });
  }
  void getStoreCategoriesWithLang(StoreCategoriesScreenState screenState,FilterLanguageCategoryRequest request) {
    _stateSubject.add(StoreCategoriesLoadingState(screenState));
    _categoriesService.getStoreCategoriesWithLang(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            StoreCategoriesLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(StoreCategoriesLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        StoreCategoriesModel model = value as StoreCategoriesModel;
        _stateSubject.add(StoreCategoriesLoadedState(screenState, model.data));
      }
    });
  }
  void createCategory(StoreCategoriesScreenState screenState,
      CreateStoreCategoryRequest request) {
    _stateSubject.add(StoreCategoriesLoadingState(screenState));
    _uploadService.uploadImage(request.dataStoreCategory?.image).then((value) {
      request.dataStoreCategory?.image = value;
      _categoriesService.createCategory(request).then((value) {
        if (value.hasError) {
          getStoreCategoriesWithLang(screenState,FilterLanguageCategoryRequest(language: screenState.languageSelected));
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getStoreCategoriesWithLang(screenState,FilterLanguageCategoryRequest(language: screenState.languageSelected));
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.categoryCreatedSuccessfully)
            ..show(screenState.context);
        }
      });
    });
  }

  void updateCategory(StoreCategoriesScreenState screenState,
      UpdateStoreCategoriesRequest request) {
    if (request.dataStoreCategory?.image?.contains('/original-image/') == true ||
        request.dataStoreCategory?.image == null) {
      _stateSubject.add(StoreCategoriesLoadingState(screenState));
      _categoriesService.updateStoreCategory(request).then((value) {
        if (value.hasError) {
              getStoreCategoriesWithLang(screenState,FilterLanguageCategoryRequest(language: screenState.languageSelected));
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getStoreCategoriesWithLang(screenState,FilterLanguageCategoryRequest(language: screenState.languageSelected));
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning, message: S.current.updateStoreCategory)
            ..show(screenState.context);
        }
      });
    } else {
      _stateSubject.add(StoreCategoriesLoadingState(screenState));
      _uploadService.uploadImage(request.dataStoreCategory?.image).then((value) {
        request.dataStoreCategory?.image = value;
        _categoriesService.updateStoreCategory(request).then((value) {
          if (value.hasError) {
            getStoreCategoriesWithLang(screenState,FilterLanguageCategoryRequest(language: screenState.languageSelected));
            CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
              ..show(screenState.context);
          } else {
            getStoreCategoriesWithLang(screenState,FilterLanguageCategoryRequest(language: screenState.languageSelected));
            CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.updateStoreCategory)
              ..show(screenState.context);
          }
        });
      });
    }
  }

  void deleteCategories(StoreCategoriesScreenState screenState, String id) {
    _stateSubject.add(StoreCategoriesLoadingState(screenState));
    _categoriesService.deleteCategories(id).then((value) {
      if (value.hasError) {
        getStoreCategoriesWithLang(screenState,FilterLanguageCategoryRequest(language: screenState.languageSelected));
            CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
              .show(screenState.context);
         
      } else {
        getStoreCategoriesWithLang(screenState,FilterLanguageCategoryRequest(language: screenState.languageSelected));
            CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.deleteSuccess)
              .show(screenState.context);
          }
      }
    );
  }
}

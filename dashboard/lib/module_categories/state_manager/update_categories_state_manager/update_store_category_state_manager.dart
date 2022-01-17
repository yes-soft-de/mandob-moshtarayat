import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/store_category_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_translation_store_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/update_categories_screen/update_store_category_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/store_categories/update_store_category_state/store_category_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class UpdateStoreCategoriesStateManager {
  final CategoriesService _categoriesService;

  final AuthService _authService;
  final ImageUploadService _uploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  UpdateStoreCategoriesStateManager(
      this._categoriesService, this._authService, this._uploadService);

  void getStoreCategory(UpdateStoreCategoryScreenState screenState, String id) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getStoreCategory(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(StoreCategoryLoaded(screenState, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(StoreCategoryLoaded(screenState, empty: value.isEmpty));
      } else {
        CategoryModel model = value as CategoryModel;
        screenState.model = model.data;
        _stateSubject.add(StoreCategoryLoaded(screenState));
      }
    });
  }

  void updateCategory(UpdateStoreCategoryScreenState screenState,
      UpdateStoreCategoriesRequest request) {
    if (request.dataStoreCategory?.image?.contains('/original-image/') ==
            true ||
        request.dataStoreCategory?.image == null) {
      _stateSubject.add(LoadingState(screenState));
      _categoriesService.updateStoreCategory(request).then((value) {
        if (value.hasError) {
          _stateSubject
              .add(StoreCategoryLoaded(screenState, error: value.error));
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
          .uploadImage(request.dataStoreCategory?.image)
          .then((value) {
        request.dataStoreCategory?.image = value;
        _categoriesService.updateStoreCategory(request).then((value) {
          if (value.hasError) {
            _stateSubject
                .add(StoreCategoryLoaded(screenState, error: value.error));
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

  void addNewTranslate(UpdateStoreCategoryScreenState screenState,
      CreateNewTransStoreCategoryRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.createNewTransStoreCategory(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(StoreCategoryLoaded(screenState, error: value.error));
      } else {
        getStoreCategory(screenState, request.storeCategoryID.toString());
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.updateStoreCategory)
          ..show(screenState.context);
      }
    });
  }
}

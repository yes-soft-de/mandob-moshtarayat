import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/sub_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/screen/sub_categories_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/ui/state/sub_categories/sub_categories_loaded_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/service/store_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

@injectable
class SubCategoriesStateManager {
  final StoresService _storesService;
  final CategoriesService _categoriesService;
  final AuthService _authService;
  final ImageUploadService _uploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  SubCategoriesStateManager(this._storesService, this._authService,
      this._uploadService, this._categoriesService);

  void getStoreCategories(SubCategoriesScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getStoreCategories().then((value) {
      if (value.hasError) {
        _stateSubject.add(SubCategoriesLoadedState(screenState, null, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(SubCategoriesLoadedState(screenState, null, null,
            empty: value.isEmpty));
      } else {
        StoreCategoriesModel model = value as StoreCategoriesModel;
        _stateSubject.add(SubCategoriesLoadedState(screenState, null ,model.data));
      }
    });
  }

  void getCategoriesLevelOne(SubCategoriesScreenState screenState,int id,List<StoreCategoriesModel> model) {
   // _stateSubject.add(LoadingState(screenState));
    _categoriesService.getSubCategories(id).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(title: S.current.warnning, message: value.error ?? '').show(screenState.context);
      } else if (value.isEmpty) {
        _stateSubject.add(SubCategoriesLoadedState(screenState, null, model));
      } else {
        SubCategoriesModel cats = value as SubCategoriesModel;
        _stateSubject.add(SubCategoriesLoadedState(screenState, cats.data ,model));
      }
    });
  }

  void createSubCategory(
      SubCategoriesScreenState screenState, SubCategoriesRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _uploadService.uploadImage(request.productCategoryImage).then((value) {
        request.productCategoryImage = value;
        _categoriesService.createSubCategories(request).then((value) {
          if (value.hasError) {
            getStoreCategories(screenState);
            CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
              ..show(screenState.context);
          } else {
            getStoreCategories(screenState);
            CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.categoryCreatedSuccessfully)
              ..show(screenState.context);
          }
        });

    });
  }

  void updateSubCategory(SubCategoriesScreenState screenState,
      SubCategoriesRequest request) {
    if (request.productCategoryImage?.contains('/original-image/') == true || request.productCategoryImage == null) {
      _stateSubject.add(LoadingState(screenState));
      _categoriesService.updateSubCategories(request).then((value) {
        if (value.hasError) {
          getStoreCategories(screenState);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getStoreCategories(screenState);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning, message: S.current.updateStoreCategory)
            ..show(screenState.context);
        }
      });
    } else {
      _stateSubject.add(LoadingState(screenState));
      _uploadService.uploadImage(request.productCategoryImage).then((value) {
          request.productCategoryImage = value;
          _categoriesService.updateSubCategories(request).then((value) {
            if (value.hasError) {
              getStoreCategories(screenState);
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
                ..show(screenState.context);
            } else {
              getStoreCategories(screenState);
              CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.updateStoreCategory)
                ..show(screenState.context);
            }
          });
      });
    }
  }

}

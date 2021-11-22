import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/stores_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/service/store_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/stores_inactive_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/stores_inactive/stores_inactive_state_loaded.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';

@injectable
class StoresInActiveStateManager {
  final StoresService _storesService;
  final CategoriesService _categoriesService;
  final AuthService _authService;
  final ImageUploadService _uploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoresInActiveStateManager(this._storesService, this._authService,
      this._uploadService, this._categoriesService);

  void getStores(StoresInActiveScreenState screenState) {
    _categoriesService.getStoreCategories().then((categories) {
      if (categories.hasError) {
        _stateSubject.add(StoresInActiveLoadedState(screenState, null, null,
            error: categories.error));
      } else if (categories.isEmpty) {
        _stateSubject.add(StoresInActiveLoadedState(screenState, null, null,
            empty: categories.isEmpty));
      } else {
        _storesService.getStoresInActive().then((value) {
          if (value.hasError) {
            _stateSubject.add(StoresInActiveLoadedState(screenState, null, null,
                error: value.error));
          } else if (value.isEmpty) {
            _stateSubject.add(StoresInActiveLoadedState(screenState, [], null));
          } else {
            StoreCategoriesModel categoriesModel =
                categories as StoreCategoriesModel;
            StoresModel model = value as StoresModel;
            _stateSubject
                .add(StoresInActiveLoadedState(screenState, model.data, categoriesModel.data));
          }
        });
      }
    });

  }

  void getStoresFilter(
      StoresInActiveScreenState screenState, String searchKey) {
    _storesService.getStoresInActiveFilter(searchKey).then((value) {
      if (value.hasError) {
        _stateSubject.add(StoresInActiveLoadedState(screenState, null, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(StoresInActiveLoadedState(screenState, [], null));
      } else {
        StoresModel model = value as StoresModel;
        _stateSubject
            .add(StoresInActiveLoadedState(screenState, model.data, null));
      }
    });
  }

  void updateStore(
      StoresInActiveScreenState screenState, UpdateStoreRequest request) {
    if (request.image!.contains('/original-image/')) {
      _stateSubject.add(LoadingState(screenState));
      _categoriesService.updateStore(request).then((value) {
        if (value.hasError) {
          getStores(screenState);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getStores(screenState);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.storeUpdatedSuccessfully)
            ..show(screenState.context);
        }
      });
    } else {
      _stateSubject.add(LoadingState(screenState));
      _uploadService.uploadImage(request.image!).then((value) {
        if (value == null) {
          getStores(screenState);
          CustomFlushBarHelper.createError(
              title: S.current.warnning,
              message: S.current.errorUploadingImages)
            ..show(screenState.context);
        } else {
          request.image = value;
          _categoriesService.updateStore(request).then((value) {
            if (value.hasError) {
              getStores(screenState);
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
                ..show(screenState.context);
            } else {
              getStores(screenState);
              CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.storeUpdatedSuccessfully)
                ..show(screenState.context);
            }
          });
        }
      });
    }
  }
}

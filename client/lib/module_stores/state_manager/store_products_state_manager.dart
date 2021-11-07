import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_stores/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/module_stores/service/store_products_service.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_empty_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_error_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_loaded_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_loading_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_products/store_products_state.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class StoreProductsStateManager {
  final StoreProductsService _storeProductsService;
  final PublishSubject<StoreProductsState> _stateSubject = PublishSubject();
  final PublishSubject<AsyncSnapshot<Object?>> _categorySubject =
      PublishSubject();
  final CartHiveHelper cartHiveHelper = CartHiveHelper();

  Stream<StoreProductsState> get stateStream => _stateSubject.stream;

  Stream<AsyncSnapshot<Object?>> get categoryStream => _categorySubject.stream;

  StoreProductsStateManager(this._storeProductsService);

  void getStoresProducts(int id, StoreProductsScreenState screenState ,[bool withoutLoading = false]) {
    if (!withoutLoading){
      _stateSubject.add(StoreProductsLoadingState(screenState));
    }
    _storeProductsService.getStoreProfile(id).then((store) {
      if (store.hasError) {
        _stateSubject
            .add(StoreProductsErrorState(screenState, [store.error ?? ''], id));
      } else if (store.isEmpty) {
        _stateSubject.add(
            StoreProductsEmptyState(screenState, S.current.homeDataEmpty, id));
      } else {
        _storeProductsService.getProductsData(id).then((value) {
          if (value.isEmpty) {
            _stateSubject.add(StoreProductsEmptyState(
                screenState, S.current.homeDataEmpty, id));
          } else if (value.hasData) {
            var data = value.data;
            StoreProfile storeData = store as StoreProfile;
            _stateSubject.add(StoreProductsLoadedState(screenState,
                topWantedProducts: data.topWanted,
                productsCategory: data.storeCategories,
                orderCart: cartHiveHelper.getCart(),
                storeProfile: storeData.profile));
            if (value.hasErrors) {
              CustomFlushBarHelper.createError(
                      title: S.current.warnning, message: value.errors[0])
                  .show(screenState.context);
            }
          } else {
            _stateSubject
                .add(StoreProductsErrorState(screenState, value.errors, id));
          }
        });
      }
    });
  }

  void getProductsByCategory(int storeId, int categoryId) {
    _categorySubject.add(AsyncSnapshot.waiting());
    _storeProductsService
        .getProductsByCategory(storeId, categoryId)
        .then((value) {
      if (value.hasError) {
        _categorySubject
            .add(AsyncSnapshot.withError(ConnectionState.done, value.error!));
      } else if (value.isEmpty) {
        _categorySubject.add(AsyncSnapshot.nothing());
      } else {
        _categorySubject
            .add(AsyncSnapshot.withData(ConnectionState.done, value.data));
      }
    });
  }

  void rateStore(
      RateStoreRequest request, StoreProductsScreenState screenState) {
    CustomFlushBarHelper.createSuccess(
      title: S.current.note,
      message: S.current.rateSubmitting,
      background: Theme.of(screenState.context).primaryColor,
    ).show(screenState.context);
    _storeProductsService.rateStore(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
          title: S.current.warnning,
          message: value.error ?? '',
        ).show(screenState.context);
      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.storeRated)
            .show(screenState.context);
      }
    });
  }
}

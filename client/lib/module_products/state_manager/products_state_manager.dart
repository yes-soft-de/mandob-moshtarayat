import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/empty_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/error_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/module_products/model/products_details_model.dart';
import 'package:mandob_moshtarayat/module_products/model/products_similar_model.dart';
import 'package:mandob_moshtarayat/module_products/service/products_service.dart';
import 'package:mandob_moshtarayat/module_products/ui/screen/products_details_screen.dart';
import 'package:mandob_moshtarayat/module_products/ui/state/product_details/products_details_loaded_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class ProductDetailsStateManager {
  final ProductsService _productsService;
  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<AsyncSnapshot<Object?>> get productsStream => _productSubject.stream;
  final PublishSubject<AsyncSnapshot<Object?>> _productSubject =
      PublishSubject();
  final CartHiveHelper cartHiveHelper = CartHiveHelper();

  Stream<States> get stateStream => _stateSubject.stream;

  ProductDetailsStateManager(this._productsService);

  void getProducts(int id, ProductDetailsScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _productsService.getProductsDetails(id).then((store) {
      if (store.hasError) {
        _stateSubject.add(ErrorState(screenState,
            error: store.error, hasAppbar: false, onPressed: () {
          getProducts(id, screenState);
        }, title: S.current.product));
      } else if (store.isEmpty) {
        _stateSubject.add(EmptyState(screenState,
            title: S.current.product,
            hasAppbar: false,
            emptyMessage: S.current.homeDataEmpty, onPressed: () {
          getProducts(id, screenState);
        }));
      } else {
        ProductsDetailsModel model = store as ProductsDetailsModel;
        _stateSubject.add(ProductDetailsLoadedState(screenState, model.data));
      }
    });
  }

  void rateProduct(
      RateStoreRequest request, ProductDetailsScreenState screenState) {
    CustomFlushBarHelper.createSuccess(
      title: S.current.note,
      message: S.current.rateSubmitting,
      background: Theme.of(screenState.context).primaryColor,
    ).show(screenState.context);
    _productsService.rateStore(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
          title: S.current.warnning,
          message: value.error ?? '',
        ).show(screenState.context);
      } else {
        getProducts(request.itemID ?? -1, screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.productRated)
            .show(screenState.context);
      }
    });
  }

  void getSimilarProduct(
      ProductDetailsScreenState screenState, int categoriesId) {
    _productSubject.add(const AsyncSnapshot.waiting());
    _productsService.getProductsSimilar(categoriesId).then((value) {
      if (value.hasError) {
        _productSubject.add(const AsyncSnapshot.waiting());
      } else if (value.isEmpty) {
        _productSubject.add(const AsyncSnapshot.nothing());
      } else {
        ProductsSimilarModel model = value as ProductsSimilarModel;
        _productSubject
            .add(AsyncSnapshot.withData(ConnectionState.done, model.data));
      }
    });
  }
}

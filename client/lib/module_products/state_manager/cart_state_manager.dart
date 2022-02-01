import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_products/model/cart_validation_model.dart';
import 'package:mandob_moshtarayat/module_products/request/products_request/product_detail.dart';
import 'package:mandob_moshtarayat/module_products/request/products_request/products_request.dart';
import 'package:mandob_moshtarayat/module_products/service/products_service.dart';
import 'package:mandob_moshtarayat/module_products/ui/screen/cart_screen.dart';
import 'package:mandob_moshtarayat/module_products/ui/state/cart/cart_loaded_state.dart';
import 'package:mandob_moshtarayat/module_stores/presistance/cart_hive_box_helper.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class CartStateManager {
  final ProductsService _productsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CartStateManager(this._productsService);

  void validateCart(CartScreenState screenState) {
    _stateSubject
        .add(LoadingState(screenState, message: S.current.cartValidation));
    List<ProductDetail> cart = [];
    getIt<CartHiveHelper>().getCart().forEach((element) {
      cart.add(ProductDetail(id: element.id, quantity: element.quantity));
    });
    _productsService
        .getCartValidation(ProductsRequest(productDetails: cart))
        .then((value) {
      if (value.hasError) {
        _stateSubject.add(CartLoadedState(screenState));
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        var model = value as CartValidationModel;
        if (model.attention) {
          CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.cartAttention,
                  background: Theme.of(screenState.context).primaryColor)
              .show(screenState.context);
        }
        _stateSubject.add(CartLoadedState(screenState));
      }
    });
  }
}

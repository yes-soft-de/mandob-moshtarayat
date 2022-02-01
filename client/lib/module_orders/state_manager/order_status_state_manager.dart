import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/module_orders/service/orders_service.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/order_status_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_status/order_status_empty_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_status/order_status_loaded_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_status/order_status_loading_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_status/order_status_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/order_status/orders_status_error_state.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/helpers/fire_store_helper.dart';

@injectable
class OrderStatusStateManager {
  final OrdersService _ordersService;
  final FireStoreHelper _fireStoreHelper;
  final PublishSubject<OrderStatusState> _stateSubject = PublishSubject();
  Stream<OrderStatusState> get stateStream => _stateSubject.stream;
  OrderStatusStateManager(this._ordersService, this._fireStoreHelper);
  StreamSubscription? newActionSubscription;

  void getOrderDetails(int id, OrderStatusScreenState screenState) {
    _stateSubject.add(OrderStatusLoadingState(screenState));
    _ordersService.getOrdersDetails(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(OrderStatusErrorState(screenState, value.error!, id));
      } else if (value.isEmpty) {
        _stateSubject.add(
            OrderStatusEmptyState(screenState, S.current.homeDataEmpty, id));
      } else {
        _stateSubject.add(OrderStatusLoadedState(screenState, value.data));
        initListening(screenState, id);
      }
    });
  }

  void initListening(OrderStatusScreenState screenState, int id) {
    newActionSubscription =
        _fireStoreHelper.onInsertChangeWatcher()?.listen((event) {
      _ordersService.getOrdersDetails(id).then((value) {
        if (value.hasError) {
          _stateSubject
              .add(OrderStatusErrorState(screenState, value.error!, id));
        } else if (value.isEmpty) {
          _stateSubject.add(
              OrderStatusEmptyState(screenState, S.current.homeDataEmpty, id));
        } else {
          _stateSubject.add(OrderStatusLoadedState(screenState, value.data));
        }
      });
    });
  }

  void rateCaptain(
      RateCaptainRequest request, OrderStatusScreenState screenState) {
    CustomFlushBarHelper.createSuccess(
      title: S.current.note,
      message: S.current.rateSubmitting,
      background: Theme.of(screenState.context).primaryColor,
    ).show(screenState.context);
    _ordersService.rateCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
          title: S.current.warnning,
          message: value.error ?? '',
        ).show(screenState.context);
      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.captainRated)
            .show(screenState.context);
      }
    });
  }
}

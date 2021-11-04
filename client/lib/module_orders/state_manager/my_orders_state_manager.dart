import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_orders/service/orders_service.dart';
import 'package:mandob_moshtarayat/module_orders/ui/screen/my_orders_screen.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/my_orders/my_orders_empty_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/my_orders/my_orders_error_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/my_orders/my_orders_loaded_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/my_orders/my_orders_loading_state.dart';
import 'package:mandob_moshtarayat/module_orders/ui/state/my_orders/my_orders_state.dart';
import 'package:mandob_moshtarayat/utils/helpers/fire_store_helper.dart';

@injectable
class MyOrdersStateManager {
  final OrdersService _myOrdersService;
  final AuthService _authService;
  final FireStoreHelper _fireStoreHelper;
  final PublishSubject<MyOrdersState> _stateSubject =
      PublishSubject<MyOrdersState>();

  Stream<MyOrdersState> get stateStream => _stateSubject.stream;

  MyOrdersStateManager(
      this._myOrdersService, this._authService, this._fireStoreHelper);

  StreamSubscription? newActionSubscription;

  void getOrders(MyOrdersScreenState screenState) {
    if (_authService.isLoggedIn) {
      _stateSubject.add(MyOrdersLoadingState(screenState));
      _myOrdersService.getOrders().then((value) {
        if (value.hasError) {
          _stateSubject.add(MyOrdersErrorState(
              screenState, value.error ?? S.current.errorHappened));
        } else if (value.isEmpty) {
          _stateSubject
              .add(MyOrdersEmptyState(screenState, S.current.homeDataEmpty));
        } else {
          _stateSubject.add(MyOrdersLoadedState(screenState, value.data));
          initListening(screenState);
        }
      });
    } else {
      screenState.goToLogin();
    }
  }

  void initListening(MyOrdersScreenState screenState) {
    newActionSubscription =
        _fireStoreHelper.onInsertChangeWatcher()?.listen((event) {
      if (_authService.isLoggedIn) {
        _myOrdersService.getOrders().then((value) {
          if (value.hasError) {
            _stateSubject.add(MyOrdersErrorState(
                screenState, value.error ?? S.current.errorHappened));
          } else if (value.isEmpty) {
            _stateSubject
                .add(MyOrdersEmptyState(screenState, S.current.homeDataEmpty));
          } else {
            _stateSubject.add(MyOrdersLoadedState(screenState, value.data));
          }
        });
      }
    });
  }
}

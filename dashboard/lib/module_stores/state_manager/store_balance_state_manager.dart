import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/store_balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/request/store_payment_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/service/store_payment.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/service/store_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/store_balance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_account/store_balance_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';

@injectable
class StoreBalanceStateManager {
  final StoresService _storesService;
  final StorePaymentsService _storePaymentsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreBalanceStateManager(this._storesService, this._storePaymentsService);

  void getBalance(StoreBalanceScreenState screenState, int storeID) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.getStoreBalance(storeID).then((value) {
      if (value.hasError) {
        _stateSubject.add(StoreBalanceLoadedState(
          screenState,
          null,
          error: value.error,
        ));
      } else if (value.isEmpty) {
        _stateSubject.add(
            StoreBalanceLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        StoreBalanceModel _balance = value as StoreBalanceModel;
        _stateSubject.add(StoreBalanceLoadedState(screenState, _balance.data));
      }
    });
  }

  void payForStore(
      StoreBalanceScreenState screenState, StorePaymentRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _storePaymentsService.paymentToStore(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        getBalance(screenState, request.storeOwnerProfileId ?? -1);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: value.error ?? S.current.paymentSuccessfully)
            .show(screenState.context);
      }
    });
  }
}

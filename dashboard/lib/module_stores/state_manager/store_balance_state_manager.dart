import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/store_balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/service/store_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/store_balance_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_account/store_balance_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';

@injectable
class StoreBalanceStateManager {
  final StoresService _storesService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreBalanceStateManager(this._storesService);

  void getBalance(
      StoreBalanceScreenState screenState, int storeID) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.getStoreBalance(storeID).then((value) {
      if (value.hasError) {
        _stateSubject.add(StoreBalanceLoadedState(
          screenState,
          null,
          error: value.error,
        ));
      } else if (value.isEmpty) {
        _stateSubject.add(StoreBalanceLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        
        StoreBalanceModel _balance = value as StoreBalanceModel;
        _stateSubject.add(
            StoreBalanceLoadedState(screenState, _balance.data));
      }
    });
  }
}

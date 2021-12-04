
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_balance/model/balance_model.dart';
import 'package:mandob_moshtarayat/module_balance/service/balance_service.dart';
import 'package:mandob_moshtarayat/module_balance/ui/screen/balance_info_screen.dart';
import 'package:mandob_moshtarayat/module_balance/ui/state/balance_loaded_state.dart';
import 'package:mandob_moshtarayat/module_balance/ui/state/balance_loading_state.dart';
import 'package:mandob_moshtarayat/module_balance/ui/state/balance_state.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class BalanceStateManager{
  final BalanceService _service;
  final AuthService _authService;

  BalanceStateManager(this._service, this._authService);

  final PublishSubject<BalanceState> _stateSubject = PublishSubject();

  Stream<BalanceState> get stateStream => _stateSubject.stream;


  void getBalanceStore(BalanceScreenState screenState){
    if(_authService.isLoggedIn){
    _service.getStorePayments().then((value) {
      if(value.hasError){
        print('ff');
        _stateSubject.add(BalanceLoaded(screenState, null ,error: value.error));
      }else if (value.isEmpty){
        print('ffdd');
        _stateSubject.add(BalanceLoaded(screenState, null ,empty:true));
      }else{
        print('ffddff');
        BalanceModel model =value as BalanceModel;
        _stateSubject.add(BalanceLoaded(screenState, model.balanceModel));
      }
    });
  }
    else {
      screenState.goToLogin();
    }
  }

}
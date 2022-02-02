import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service.dart';
import 'package:mandob_moshtarayat/module_balance/model/balance_model.dart';
import 'package:mandob_moshtarayat/module_balance/service/balance_service.dart';
import 'package:mandob_moshtarayat/module_balance/ui/screen/balance_screen.dart';
import 'package:mandob_moshtarayat/module_balance/ui/state/balance_loaded_state.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class BalanceStateManager {
  final BalanceService _service;
  final ImageUploadService _uploadService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  BalanceStateManager(this._service, this._uploadService, this._authService);

  void getFilteredDateBalance(BalanceScreenState screenState, String firstDate, String lastDate) {
    _stateSubject.add(LoadingState(screenState));
    _service.getFilteredDateBalance(firstDate, lastDate).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            BalanceLoadedState(screenState,null, error: value.error));
      }
     else if (value.isEmpty) {
       print('empty');
        _stateSubject.add(BalanceLoadedState(screenState, null, empty: true));
      }
     else {
        BalanceModel model = value as BalanceModel;
        _stateSubject.add(BalanceLoadedState(screenState, model.balanceModel));
      }});
  }
}

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/captain_model_payment_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/service/captains_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/catpains_payment_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/state/captains_payments/captains_payments_loaded_state.dart';

@injectable
class CaptainsPaymentsStateManager {
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CaptainsPaymentsStateManager(this._captainsService);

  void getCaptains(CaptainsPaymentsScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getPayments().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            CaptainsPaymentsLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(CaptainsPaymentsLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainPaymentModel _model = value as CaptainPaymentModel;
        _stateSubject
            .add(CaptainsPaymentsLoadedState(screenState, _model.data));
      }
    });
  }
}

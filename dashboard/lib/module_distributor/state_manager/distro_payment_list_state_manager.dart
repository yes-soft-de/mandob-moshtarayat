import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/distro_payment_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/service/distributer_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distros_payment_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/state/captains_payments/captains_payments_loaded_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';

@injectable
class DistrosPaymentsStateManager {
  final DistributorService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  DistrosPaymentsStateManager(this._captainsService);

  void getDistros(DistrosPaymentsScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getPayments().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            DistrosPaymentsLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(DistrosPaymentsLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        DistroPaymentModel _model = value as DistroPaymentModel;
        _stateSubject
            .add(DistrosPaymentsLoadedState(screenState, _model.data));
      }
    });
  }
}

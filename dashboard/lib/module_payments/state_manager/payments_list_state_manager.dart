import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/model/payments_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/service/payments_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/screen/payments_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/state/payments_list/payments_list_loaded_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';

@injectable
class PaymentsListStateManager {
  final PaymentsService _paymentsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  PaymentsListStateManager(this._paymentsService);

  void getPayments(PaymentsListScreenState screenState) {
    _paymentsService.getPayments().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(PaymentsLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(PaymentsLoadedState(screenState, null, empty: true));
      } else {
         PaymentsModel paymentsModel = value as PaymentsModel;
        _stateSubject.add(PaymentsLoadedState(screenState, paymentsModel.data));
      }
    });
  }
}

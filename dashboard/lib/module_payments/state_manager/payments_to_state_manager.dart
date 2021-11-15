import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/porfile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/service/captains_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/service/payments_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/screen/paymen_from_captain_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/screen/payment_to_captain_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/state/payment_to_captain/captains_payments_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/state/payments_from_captain/captains_payments_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

@injectable
class PaymentsToCaptainStateManager {
  final CaptainsService _captainsService;
  final PaymentsService _paymentsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  PaymentsToCaptainStateManager(this._captainsService, this._paymentsService);

  void getCaptainPaymentsDetails(
      PaymentsToCaptainScreenState screenState, int captainId) {
    _stateSubject.add(LoadingState(screenState));
    Future.wait([
      _captainsService.getCaptainProfile(captainId),
      _captainsService.getCaptainBalance(captainId)
    ]).then((value) {
      if (value[0].hasError || value[1].hasError) {
        _stateSubject.add(PaymentsToCaptainLoadedState(
          screenState,
          null,
          null,
          error: value[0].error ?? value[1].error,
        ));
      } else if (value[0].isEmpty || value[1].isEmpty) {
        _stateSubject.add(PaymentsToCaptainLoadedState(screenState, null, null,
            empty: value.isEmpty));
      } else {
        ProfileModel _model = value[0] as ProfileModel;
        BalanceModel _balance = value[1] as BalanceModel;
        _stateSubject.add(
            PaymentsToCaptainLoadedState(screenState, _model.data, _balance));
      }
    });
  }

  void makePayments(PaymentsToCaptainScreenState screenState,
      CaptainPaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _paymentsService.paymentToCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getCaptainPaymentsDetails(screenState, request.captainId ?? -1);
      } else {
        getCaptainPaymentsDetails(screenState, request.captainId ?? -1);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.paymentSuccessfully)
            .show(screenState.context);
      }
    });
  }
}

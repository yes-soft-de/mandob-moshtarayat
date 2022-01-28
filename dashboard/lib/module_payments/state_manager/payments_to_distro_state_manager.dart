import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/profile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/service/distributer_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/distro_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/screen/payment_to_distro_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/state/payment_to_distro/distros_payments_loaded_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/service/payments_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

@injectable
class PaymentsToDistroStateManager {
  final DistributorService _distributorService;
  final PaymentsService _paymentsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  PaymentsToDistroStateManager(this._distributorService, this._paymentsService);

  void getDistroPaymentsDetails(
      PaymentsToDistroScreenState screenState, int captainId) {
    _stateSubject.add(LoadingState(screenState));
    Future.wait([
      _distributorService.getDistorProfile(captainId),
      _distributorService.getDistroBalance(captainId)
    ]).then((value) {
      if (value[0].hasError || value[1].hasError) {
        _stateSubject.add(PaymentsToDistrosLoadedState(
          screenState,
          null,
          null,
          error: value[0].error ?? value[1].error,
        ));
      } else if (value[0].isEmpty || value[1].isEmpty) {
        _stateSubject.add(PaymentsToDistrosLoadedState(screenState, null, null,
            empty: value.isEmpty));
      } else {
        ProfileModel _model = value[0] as ProfileModel;
        BalanceModel _balance = value[1] as BalanceModel;
        _stateSubject.add(
            PaymentsToDistrosLoadedState(screenState, _model.data, _balance));
      }
    });
  }

  void makePayments(PaymentsToDistroScreenState screenState,
      DistroPaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _paymentsService.paymentToDistro(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getDistroPaymentsDetails(screenState, request.representativeID ?? -1);
      } else {
        getDistroPaymentsDetails(screenState, request.representativeID ?? -1);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.paymentSuccessfully)
            .show(screenState.context);
      }
    });
  }

  void deletePayment(PaymentsToDistroScreenState screenState, String id) {
    _stateSubject.add(LoadingState(screenState));
    _paymentsService.deletePaymentToDistro(id).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getDistroPaymentsDetails(screenState, screenState.captainId);
      } else {
        getDistroPaymentsDetails(screenState, screenState.captainId);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.deleteSuccess)
            .show(screenState.context);
      }
    });
  }
}

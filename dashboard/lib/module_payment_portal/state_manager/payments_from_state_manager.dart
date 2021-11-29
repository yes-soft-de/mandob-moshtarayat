import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/request/pay_tabs_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/service/portals_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/ui/screen/paymen_from_captain_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/screen/paymen_from_captain_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

@injectable
class PortalsStateManager {
  final PortalsService _payService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  PortalsStateManager(this._payService);

  void makePayments(PortalScreenState screenState, PayTabsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _payService.paymentFromCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.paymentSuccessfully)
            .show(screenState.context);
      }
    });
  }
}

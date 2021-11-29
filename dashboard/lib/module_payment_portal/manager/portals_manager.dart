import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/repository/portals_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/request/pay_tabs_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/response/pay_tabs_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/repository/payments_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';

@injectable
class PortalsManager {
  final PortalsRepository _paymentsRepository;

  PortalsManager(this._paymentsRepository);

  Future<PayTabsResponse?> paymentFromCaptain(PayTabsRequest request) =>
      _paymentsRepository.paymentFromCaptain(request);
}

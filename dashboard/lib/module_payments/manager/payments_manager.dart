import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/repository/payments_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';

@injectable
class PaymentsManager {
  final PaymentsRepository _paymentsRepository;

  PaymentsManager(this._paymentsRepository);

  Future<ActionResponse?> paymentFromCaptain(CaptainPaymentsRequest request) =>
      _paymentsRepository.paymentFromCaptain(request);
  Future<ActionResponse?> paymentToCaptain(CaptainPaymentsRequest request) =>
      _paymentsRepository.paymentToCaptain(request);
}

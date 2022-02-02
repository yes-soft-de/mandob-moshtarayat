import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/repository/payments_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/distro_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/response/payment_list_response/payment_list_response.dart';

@injectable
class PaymentsManager {
  final PaymentsRepository _paymentsRepository;

  PaymentsManager(this._paymentsRepository);

  Future<ActionResponse?> paymentFromCaptain(CaptainPaymentsRequest request) =>
      _paymentsRepository.paymentFromCaptain(request);
  Future<ActionResponse?> paymentToCaptain(CaptainPaymentsRequest request) =>
      _paymentsRepository.paymentToCaptain(request);
  Future<ActionResponse?> paymentToDistro(DistroPaymentsRequest request) =>
      _paymentsRepository.paymentToDistro(request);
  Future<ActionResponse?> deletePaymentToCaptain(String id) =>
      _paymentsRepository.deletePaymentToCaptain(id);
  Future<ActionResponse?> deletePaymentToDistro(String id) =>
      _paymentsRepository.deletePaymentToDistro(id);
  Future<ActionResponse?> deletePaymentFromCaptain(String id) =>
      _paymentsRepository.deletePaymentFromCaptain(id);
  Future<PaymentListResponse?> getPaymentList() =>
      _paymentsRepository.paymentsList();
}

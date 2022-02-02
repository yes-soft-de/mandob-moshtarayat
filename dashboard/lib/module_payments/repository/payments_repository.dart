import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/distro_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/response/payment_list_response/payment_list_response.dart';

@injectable
class PaymentsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  PaymentsRepository(this._apiClient, this._authService);

  Future<ActionResponse?> paymentFromCaptain(
      CaptainPaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.PAYMENTS_FROM_CAPTAIN, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> paymentToCaptain(
      CaptainPaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.PAYMENTS_TO_CAPTAIN, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deletePaymentToCaptain(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.DELETE_PAYMENTS_TO_CAPTAIN + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deletePaymentFromCaptain(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.DELETE_PAYMENTS_FROM_CAPTAIN + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<PaymentListResponse?> paymentsList() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.PAYMENTS_LIST,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return PaymentListResponse.fromJson(response);
  }


  Future<ActionResponse?> paymentToDistro(
      DistroPaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.PAYMENTS_TO_DISTRO, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
  Future<ActionResponse?> deletePaymentToDistro(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.DELETE_PAYMENTS_TO_DISTRO + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

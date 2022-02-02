import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
 import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/request/accept_distro_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distro_unfinished_pyments_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distirbutor_reponse.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distro_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_network/http_client/http_client.dart';

@injectable
class DistributorRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  DistributorRepository(this._apiClient, this._authService);

  Future<DistributorResponse?> getInActiveDistributor() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_DISTRO_API + 'inactive',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return DistributorResponse.fromJson(response);
  }

  Future<DistributorResponse?> getDistro() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_DISTRO_API + 'active',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return DistributorResponse.fromJson(response);
  }

  Future<DistributorProfileResponse?> getDistorsProfile(int distroId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_DISTRO_PROFILE + '$distroId',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return DistributorProfileResponse.fromJson(response);
  }

  Future<DistroAccountBalanceResponse?> getDistroAccountBalance(
      int captainId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_ACCOUNT_BALANCE_DISTRO + '$captainId',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return DistroAccountBalanceResponse.fromJson(response);
  }

  Future<DistroAccountBalanceResponse?> getDistroAccountBalanceLastBalance(
      int captainId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_ACCOUNT_BALANCE_DISTRO_LAST_MONTH + '$captainId',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return DistroAccountBalanceResponse.fromJson(response);
  }

//  Future<CaptainUnfinishedPaymentsResponse?> captainPayments() async {
//    var token = await _authService.getToken();
//    dynamic response = await _apiClient.get(Urls.GET_UNFINISHED_PAYMENT,
//        headers: {'Authorization': 'Bearer ' + token.toString()});
//    if (response == null) return null;
//    return CaptainUnfinishedPaymentsResponse.fromJson(response);
//  }
//
  Future<DistroUnfinishedPaymentsResponse?> distroRemainingPayments() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_REMAINING_PAYMENT_TO_DISTRO,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return DistroUnfinishedPaymentsResponse.fromJson(response);
  }
//
  Future<ActionResponse?> enableDistro(AcceptDistroRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.ACTIVATE_DISTRO, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<DistroAccountBalanceResponse?> getCaptainSpecificDate(
      int captainId, String firstDate, String lastDate) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_ACCOUNT_BALANCE_DISTRO_SPECIFIC +
            '$captainId' +
            '/$firstDate' +
            '/$lastDate',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return DistroAccountBalanceResponse.fromJson(response);
  }
}

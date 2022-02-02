import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/consts/urls.dart';
import 'package:mandob_moshtarayat_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_captain/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat_captain/module_plan/response/account_balance_response.dart';

@injectable
class PackageBalanceRepository {
  final AuthService _authService;
  final ApiClient _apiClient;
  PackageBalanceRepository(this._authService, this._apiClient);

  Future<AccountBalanceResponse?> getCaptainPackage() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.CAPTAIN_BALANCE_ACCOUNT,
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return AccountBalanceResponse.fromJson(response);
  }

  Future<AccountBalanceResponse?> getCaptainPackageLastBalance() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.CAPTAIN_BALANCE_LAST_MONTH,
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return AccountBalanceResponse.fromJson(response);
  }

  // Future<PaymentListReponse> getCaptainBalance() async {
  //   ApiClient client = new ApiClient(new Logger());
  //   await _authService.refreshToken();
  //   var token = await _authService.getToken();
  //   var response = await client
  //       .get(Urls.GET_CAPTAIN_BALANCE, headers: {
  //     'Authorization': 'Bearer ' + token,
  //   });
  //
  //   if (response == null) return null;
  //
  //   return PaymentListReponse.fromJson(response);
  // }
  //   Future<BalanceDetailsResponse> getCaptainBalanceDetails() async {
  //   ApiClient client = new ApiClient(new Logger());
  //   await _authService.refreshToken();
  //   var token = await _authService.getToken();
  //   var response = await client
  //       .get(Urls.GET_CAPTAIN_BALANCE_DETAILS, headers: {
  //     'Authorization': 'Bearer ' + token,
  //   });
  //
  //   if (response == null) return null;
  //
  //   return BalanceDetailsResponse.fromJson(response);
  // }
}

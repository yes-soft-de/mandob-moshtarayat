import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service.dart';
import 'package:mandob_moshtarayat/module_balance/response/balance_response.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';

@injectable
class BalanceRepository {

  final ApiClient _apiClient;
  final AuthService _authService;

  BalanceRepository(this._apiClient,this._authService);


  Future<BalanceResponse?> getFilteredDateBalance(
      String firstDate, String lastDate) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_BALANCE + '$firstDate' + '/$lastDate',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return BalanceResponse.fromJson(response);
  }


}

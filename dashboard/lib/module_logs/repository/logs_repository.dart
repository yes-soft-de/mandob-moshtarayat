import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/response/captain_logs_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_network/http_client/http_client.dart';

@injectable
class LogsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  LogsRepository(this._apiClient, this._authService);

  Future<CaptainLogsResponse?> getCaptainLogs(int captainId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_CAPTAINS_LOGS + '$captainId',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainLogsResponse.fromJson(response);
  }

  Future<CaptainLogsResponse?> getStoreLogs(int storeId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_STORES_LOGS + '$storeId',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainLogsResponse.fromJson(response);
  }
}

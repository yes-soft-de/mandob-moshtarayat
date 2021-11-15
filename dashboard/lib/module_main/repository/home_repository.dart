import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_main/response/report_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_network/http_client/http_client.dart';

@injectable
class HomeRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  HomeRepository(this._apiClient, this._authService);

  Future<ReportResponse?> getReport() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_REPORT,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ReportResponse.fromJson(response);
  }
}

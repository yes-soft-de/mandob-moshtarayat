import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/in_active_captain_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/response/captain_filter_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/response/stores_filter_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_network/http_client/http_client.dart';

@injectable
class FiltersRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  FiltersRepository(this._apiClient, this._authService);

  Future<CaptainFilterResponse?> getCaptainFilter(String searchKey) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.CAPTAIN_FILTER + '$searchKey',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainFilterResponse.fromJson(response);
  }

  Future<StoresFilterResponse?> getStoreFilter(String searchKey) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.STORE_FILTER + searchKey,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StoresFilterResponse.fromJson(response);
  }
}

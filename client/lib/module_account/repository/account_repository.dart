import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_account/request/profile_request.dart';
import 'package:mandob_moshtarayat/module_account/response/post_profile_response.dart';
import 'package:mandob_moshtarayat/module_account/response/profile_response.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';

@injectable
class AccountRepository {
  final AuthService _authService;
  final ApiClient _apiClient;

  AccountRepository(this._authService, this._apiClient);

  Future<ProfileResponse?> getClientProfile() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_PROFILE_API,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ProfileResponse.fromJson(response);
  }

  Future<PostProfilerResponse?> postClientProfile(
      ProfileRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.POST_PROFILE_API, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return PostProfilerResponse.fromJson(response);
  }
  
}

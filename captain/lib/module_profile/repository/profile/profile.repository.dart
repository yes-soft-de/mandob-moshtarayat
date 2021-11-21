import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/consts/urls.dart';
import 'package:mandob_moshtarayat_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_captain/module_init/response/create_profile_response/create_profile_response.dart';
import 'package:mandob_moshtarayat_captain/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/terms/terms_respons.dart';
import 'package:mandob_moshtarayat_captain/module_profile/request/profile/profile_request.dart';
import 'package:mandob_moshtarayat_captain/module_profile/response/get_records_response.dart';
import 'package:mandob_moshtarayat_captain/module_profile/response/profile_response.dart';

@injectable
class ProfileRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ProfileRepository(
    this._apiClient,
    this._authService,
  );

  Future<ProfileResponse?> getCaptainProfile() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.CAPTAIN_PROFILE_API,
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) {
      return null;
    }
    return ProfileResponse.fromJson(response);
  }

  Future<CreateCaptainProfileResponse?> createCaptainProfile(
      ProfileRequest profileRequest) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.CAPTAIN_PROFILE_API,
      profileRequest.toJSON(),
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );

    if (response == null) return null;

    return CreateCaptainProfileResponse.fromJson(response);
  }

  Future<List<ActivityRecord>?> getUserActivityLog() async {
    await _authService.refreshToken();
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.LOG_API,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) return null;

    return GetRecordsResponse.fromJson(response).data;
  }

  Future<List<Terms>?> getTerms() async {
    var token = await _authService.getToken();
    dynamic response;

    response = await _apiClient
        .get(Urls.TERMS_CAPTAIN, headers: {'Authorization': 'Bearer $token'});

    if (response == null) return null;

    return TermsResponse.fromJson(response).data;
  }
}

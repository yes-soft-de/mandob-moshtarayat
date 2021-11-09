

import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_init/request/create_bank_account/create_bank_account.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat/module_init/response/create_profile_response/create_profile_response.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';

@injectable
class InitAccountRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  InitAccountRepository(this._apiClient, this._authService);


  Future<CreateCaptainProfileResponse?> createStoreProfile(
      CreateStoreRequest request) async {
    var token =  await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.CREATE_CAPTAIN_PROFILE,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) return null;
    return CreateCaptainProfileResponse.fromJson(response);
  }

}

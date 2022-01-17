import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service.dart';
import 'package:mandob_moshtarayat/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/module_profile/response/action_response.dart';
import 'package:mandob_moshtarayat/module_profile/response/profile_response.dart';

@injectable
class ProfileRepository {

  final ApiClient _apiClient;
  final AuthService _authService;

  ProfileRepository(this._apiClient,this._authService);


  Future<ProfileResponse?> getProfile() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_MANDOB_PROFILE ,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ProfileResponse.fromJson(response);
  }

  Future<ActionResponse?> updateProfile(CreateMandobRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(Urls.CREATE_MANDOB_PROFILE,request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }


}

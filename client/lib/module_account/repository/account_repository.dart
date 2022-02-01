import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_account/request/favorite_categories.dart';
import 'package:mandob_moshtarayat/module_account/request/profile_request.dart';
import 'package:mandob_moshtarayat/module_account/response/favourite_categories_response/favourite_categories_response.dart';
import 'package:mandob_moshtarayat/module_account/response/post_profile_response.dart';
import 'package:mandob_moshtarayat/module_account/response/profile_response.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/utils/response/action_response.dart';

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

  Future<FavouriteCategoriesResponse?> getUserFavorite() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_FAVORITE_CLIENT_API,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return FavouriteCategoriesResponse.fromJson(response);
  }

  Future<ActionResponse?> createUserFavorite(
      FavoriteCategoriesRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.UPDATE_FAVORITE_CLIENT_API, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateUserFavorite(
      FavoriteCategoriesRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_FAVORITE_CLIENT_API, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

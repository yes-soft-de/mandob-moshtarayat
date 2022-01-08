import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/di/di_config.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/sub_categories_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/main_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/sub_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/response/store_categories_linking_response/store_categories_linking_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/response/sub_categories_linking_response/sub_categories_linking_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_network/http_client/http_client.dart';

@injectable
class LinkingRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  final LocalizationService _localizationService;

  LinkingRepository(
      this._apiClient, this._authService, this._localizationService);

  Future<StoreCategoriesLinkingResponse?> getStoreCategories(String id) async {
    var token = await _authService.getToken();
    dynamic response =
        await _apiClient.post(Urls.STORE_CATEGORIES_LINKING_API, {
      'language': getIt<LocalizationService>().getLanguage(),
      'storeProductCategoryLevelOneID': id
    }, headers: {
      'Authorization': 'Bearer ' + token.toString(),
    });
    if (response == null) return null;
    return StoreCategoriesLinkingResponse.fromJson(response);
  }

  Future<SubCategoriesResponse?> getSubcategoriesLevelOne() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.GET_ALL_SUBCATEGORIES_LEVEL_ONE,
        {'language': getIt<LocalizationService>().getLanguage()},
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return SubCategoriesResponse.fromJson(response);
  }

  Future<SubCategoriesResponse?> getSubcategoriesLevelTow() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.GET_ALL_SUBCATEGORIES_LEVEL_TOW,
        {'language': getIt<LocalizationService>().getLanguage()},
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return SubCategoriesResponse.fromJson(response);
  }

  Future<SubCategoriesLinkingResponse?> getSubCategoriesLinking(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient
        .post(Urls.GET_ALL_SUBCATEGORIES_LEVEL_ONE_LINKING_API, {
      'language': getIt<LocalizationService>().getLanguage(),
      'storeProductCategoryLevelTwoID': id
    }, headers: {
      'Authorization': 'Bearer ' + token.toString()
    });
    if (response == null) return null;
    return SubCategoriesLinkingResponse.fromJson(response);
  }

  Future<ActionResponse?> updateMainLink(MainLinkRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_MAIN_CATEGORIES_LINK, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateSubLink(SubLinkRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_SUB_CATEGORIES_LINK, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

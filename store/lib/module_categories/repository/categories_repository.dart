import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/response/products_category_response.dart';
import 'package:mandob_moshtarayat/module_categories/response/response.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_categories_response.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_products_response.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/utils/helpers/laguage_code_helper.dart';

@injectable
class CategoriesRepository {

  final ApiClient _apiClient;
  final AuthService _authService;
  final LocalizationService _localizationService;

  CategoriesRepository(this._apiClient,this._authService, this._localizationService);

  Future<StoreCategoriesResponse?> getStoreCategories() async {
    var token = await _authService.getToken();
    var lang = LanguageCodeHelper.getLanguageName(_localizationService.getLanguage());
    dynamic response = await _apiClient.get(Urls.STORE_CATEGORIES,
        headers: {'Authorization': 'Bearer ' + token.toString(),  'Accept-Language':lang});
    if (response == null) return null;
    return StoreCategoriesResponse.fromJson(response);
  }

  Future<ProductsCategoryResponse?> getCategoryLevelTwo(int levelOne) async {
    var token = await _authService.getToken();
    var lang = LanguageCodeHelper.getLanguageName(_localizationService.getLanguage());
    dynamic response = await _apiClient.get(Urls.CATEGORY_LEVEL_TWO + '$levelOne',
        headers: {'Authorization': 'Bearer ' + token.toString(),  'Accept-Language':lang});
    if (response == null) return null;
    return ProductsCategoryResponse.fromJson(response);
  }

  Future<ProductsCategoryResponse?> getCategoryLevelOne() async {
    var token = await _authService.getToken();
    var lang = LanguageCodeHelper.getLanguageName(_localizationService.getLanguage());
    dynamic response = await _apiClient.get(Urls.CATEGORY_LEVEL_ONE,
        headers: {'Authorization': 'Bearer ' + token.toString(),'Accept-Language':lang});
    if (response == null) return null;
    return ProductsCategoryResponse.fromJson(response);
  }
  Future<StoreProductsResponse?> getProductsLevelTwo(int id) async {
    var token = await _authService.getToken();
    var lang = LanguageCodeHelper.getLanguageName(_localizationService.getLanguage());

    dynamic response = await _apiClient.get(Urls.GET_STORE_PRODUCT_BY_Category + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString(),  'Accept-Language':lang});
    if (response == null) return null;
    return StoreProductsResponse.fromJson(response);
  }
  Future<StoreProductsResponse?> getProductsLevelOne(int id) async {
    var token = await _authService.getToken();
    var lang = LanguageCodeHelper.getLanguageName(_localizationService.getLanguage());
    dynamic response = await _apiClient.get(Urls.GET_STORE_PRODUCT_BY_Category_LEVEL_ONE + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString(),  'Accept-Language':lang});
    if (response == null) return null;
    return StoreProductsResponse.fromJson(response);
  }
  Future<StoreProductsResponse?> getStoreProducts(String name) async {
    var token = await _authService.getToken();
    var lang = LanguageCodeHelper.getLanguageName(_localizationService.getLanguage());
    dynamic response = await _apiClient.post(Urls.GET_STORE_PRODUCT,{
      'name':name,'language':lang
    },
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StoreProductsResponse.fromJson(response);
  }
  Future<ActionResponse?> createProduct(CreateProductRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(Urls.CREATE_PRODUCTS,request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }


  Future<ActionResponse?> updateProduct(UpdateProductRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(Urls.UPDATE_PRODUCT,request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }


  Future<ActionResponse?> updateProductStatus(UpdateProductStatusRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(Urls.UPDATE_PRODUCT_Status,request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
  Future<ActionResponse?> deleteProduct(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(Urls.DELETE_PRODUCT + '$id',{},
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }


}

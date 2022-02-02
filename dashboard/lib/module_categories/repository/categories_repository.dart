import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/category_level_tow_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_products_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_store_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_translation_product_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_translation_store_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/filter_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/sub_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_product_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/product_category_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_category_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/products_category_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_categories_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_products_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/sub_categories_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_network/http_client/http_client.dart';

@injectable
class CategoriesRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  final LocalizationService _localizationService;

  CategoriesRepository(
      this._apiClient, this._authService, this._localizationService);

  Future<StoreCategoriesResponse?> getStoreCategories() async {
    var token = await _authService.getToken();
    var lang = _localizationService.getLanguage();
    dynamic response = await _apiClient.get(Urls.STORE_CATEGORIES, headers: {
      'Authorization': 'Bearer ' + token.toString(),
      'Accept-Language': lang
    });
    if (response == null) return null;
    return StoreCategoriesResponse.fromJson(response);
  }

  Future<CategoryResponse?> getStoreCategory(String id) async {
    var token = await _authService.getToken();
    var lang = _localizationService.getLanguage();
    dynamic response = await _apiClient.get(Urls.GET_STORE_CATEGORY + '$id',
        headers: {
          'Authorization': 'Bearer ' + token.toString(),
          'Accept-Language': 'ar'
        });
    if (response == null) return null;
    return CategoryResponse.fromJson(response);
  }

  Future<ProductCategoryResponse?> getProductCategory(String id) async {
    var token = await _authService.getToken();
    var lang = _localizationService.getLanguage();
    dynamic response = await _apiClient.get(Urls.GET_PRODUCT_CATEGORY + '$id',
        headers: {
          'Authorization': 'Bearer ' + token.toString(),
          'Accept-Language': 'ar'
        });
    if (response == null) return null;
    return ProductCategoryResponse.fromJson(response);
  }

  Future<ActionResponse?> createNewTransStoreCategory(
      CreateNewTransStoreCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_NEW_TRANS_STORE_CATEGORY, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> createNewTransProductCategory(
      CreateNewTransProductCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_NEW_TRANS_PRODUCT_CATEGORY, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<StoreCategoriesResponse?> getStoreCategoriesWithLang(
      FilterLanguageCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.STORE_CATEGORIES, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StoreCategoriesResponse.fromJson(response);
  }

  Future<SubCategoriesResponse?> getSubcategoriesLevelOne(
      FilterLanguageAndCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.GET_SUBCATEGORIES_LEVEL_ONE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return SubCategoriesResponse.fromJson(response);
  }

  Future<SubCategoriesResponse?> getSubcategoriesLevelTow(
      FilterLanguageAndProductCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.GET_SUBCATEGORIES_LEVEL_TOW, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return SubCategoriesResponse.fromJson(response);
  }

  Future<ActionResponse?> addCategory(
      CreateStoreCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_STORE_CATEGORIES, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ProductsCategoryResponse?> getProductsCategory(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_PRODUCTS_CATEGORY + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ProductsCategoryResponse.fromJson(response);
  }

  Future<StoreProductsResponse?> getProducts(int id) async {
    var token = await _authService.getToken();
    var lang = _localizationService.getLanguage();
    dynamic response = await _apiClient.get(Urls.GET_PRODUCTS + '$id',
        headers: {
          'Authorization': 'Bearer ' + token.toString(),
          'Accept-Language': lang
        });
    if (response == null) return null;
    return StoreProductsResponse.fromJson(response);
  }

  Future<ActionResponse?> createProductsCategory(
      CategoryLevelTowRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_SUBCATEGORIES_LEVEL_TOW, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> createProduct(CreateProductRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_PRODUCTS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateStoreCategories(
      UpdateStoreCategoriesRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_STORE_CATEGORY, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateStore(UpdateStoreRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(Urls.UPDATE_STORE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateProductCategory(
      CategoryLevelTowRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.CREATE_SUBCATEGORIES_LEVEL_TOW, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateProduct(UpdateProductRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_PRODUCT, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateProductCommission(
      UpdateProductCommissionRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_PRODUCT_COMMISSION, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> createSubCategories(
      SubCategoriesRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_SUB_CATEGORIES, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateSubCategories(
      SubCategoriesRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.CREATE_SUB_CATEGORIES, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteCategories(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(Urls.DELETE_CATEGORIES + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> getCategory(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.DELETE_CATEGORIES + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteSubCategories(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.DELETE_SUB_CATEGORIES + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

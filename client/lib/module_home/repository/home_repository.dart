import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_home/response/best_store.dart';
import 'package:mandob_moshtarayat/module_home/response/favorite_response/favorite_response.dart';
import 'package:mandob_moshtarayat/module_home/response/products.dart';
import 'package:mandob_moshtarayat/module_home/response/products_by_categories_response.dart';
import 'package:mandob_moshtarayat/module_home/response/store_categories.dart';
import 'package:mandob_moshtarayat/module_home/response/sub_categories_response.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_category_list.dart';

@injectable
class HomeRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  HomeRepository(this._apiClient, this._authService);

  Future<ProductsResponse?> getTopProducts() async {
    dynamic response = await _apiClient.get(Urls.GET_TOP_PRODUCTS_API);
    if (response == null) return null;
    return ProductsResponse.fromJson(response);
  }

  Future<StoreCategoriesResponse?> getStoreCategories() async {
    dynamic response = await _apiClient.get(Urls.GET_STORE_CATEGORIES_API);
    if (response == null) return null;
    return StoreCategoriesResponse.fromJson(response);
  }

  Future<StoreCategoryList?> getBestStores() async {
    dynamic response = await _apiClient.get(Urls.GET_BEST_STORES_API);
    if (response == null) return null;
    return StoreCategoryList.fromJson(response);
  }

  Future<SubCategoriesResponse?> getSubCategories(String categoriesID) async {
    dynamic response =
        await _apiClient.get(Urls.GET_SUBCATEGORIES_API + categoriesID);
    if (response == null) return null;
    return SubCategoriesResponse.fromJson(response);
  }

  Future<ProductsByCategoriesResponse?> getCategoriesProducts(
      String categoriesID) async {
    dynamic response =
        await _apiClient.get(Urls.GET_PRODUCTS_BY_CATEGORIES + categoriesID);
    if (response == null) return null;
    return ProductsByCategoriesResponse.fromJson(response);
  }

  Future<ProductsByCategoriesResponse?> getSubCategoriesProducts(
      String categoriesID) async {
    dynamic response =
        await _apiClient.get(Urls.GET_PRODUCTS_BY_SUBCATEGORIES + categoriesID);
    if (response == null) return null;
    return ProductsByCategoriesResponse.fromJson(response);
  }

  Future<ProductsByCategoriesResponse?> getMainCategoryProducts(
      String categoriesID) async {
    dynamic response = await _apiClient
        .get(Urls.GET_PRODUCTS_BY_MAIN_CATEGORIES + categoriesID);
    if (response == null) return null;
    return ProductsByCategoriesResponse.fromJson(response);
  }

  Future<ProductsByCategoriesResponse?> getProductsByStore(
      String storeID) async {
    var token = await _authService.getToken();
    dynamic response;
    if (token != null) {
      response = await _apiClient.get(Urls.GET_PRODUCTS_BY_STORES + storeID,
          headers: {'Authorization': 'Bearer ' + token.toString()});
    } else {
      response = await _apiClient.get(
        Urls.GET_PRODUCTS_BY_STORES + storeID,
      );
    }
    if (response == null) return null;
    return ProductsByCategoriesResponse.fromJson(response);
  }

  Future<FavoriteResponse?> getFavoriteCategories() async {
    var token = await _authService.getToken();
    dynamic response;
    if (token != null) {
      response = await _apiClient.get(Urls.GET_FAVORITE_CATEGORIES,
          headers: {'Authorization': 'Bearer ' + token.toString()});
    } else {
      response = await _apiClient.get(
        Urls.GET_FAVORITE_CATEGORIES,
      );
    }
    if (response == null) return null;
    return FavoriteResponse.fromJson(response);
  }
}

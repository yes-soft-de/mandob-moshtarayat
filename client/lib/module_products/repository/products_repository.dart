import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/module_orders/response/client_order_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/module_stores/response/products_by_category.dart';
import 'package:mandob_moshtarayat/module_stores/response/products_category.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_products.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_profile_response.dart';

@injectable
class StoreProductsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  StoreProductsRepository(this._apiClient, this._authService);

  Future<StoreProfileResponse?> getStoreProfile(int id) async {
    dynamic response = await _apiClient.get(Urls.GET_STORE_PROFILE + '$id');
    if (response == null) return null;
    return StoreProfileResponse.fromJson(response);
  }

  Future<StoreProducts?> getMostWantedProducts(int id) async {
    dynamic response =
        await _apiClient.get(Urls.GET_MOST_WANTED_STORE_PRODUCTS + '/$id');
    if (response == null) return null;
    return StoreProducts.fromJson(response);
  }

  Future<ProductsCategory?> getCategories(int id) async {
    dynamic response =
        await _apiClient.get(Urls.GET_PRODUCTS_CATEGORY_API + '/$id');
    if (response == null) return null;
    return ProductsCategory.fromJson(response);
  }

  Future<ProductsByCategory?> getProductsByCategory(
      int storeId, int categoryId) async {
    dynamic response = await _apiClient
        .get(Urls.GET_PRODUCTS_BY_CATEGORY_API + '/$categoryId' + '/$storeId');
    if (response == null) return null;
    return ProductsByCategory.fromJson(response);
  }

  Future<RateResponse?> createRateForStore(RateStoreRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(Urls.RATE_STORE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return RateResponse.fromJson(response);
  }
}

import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/module_products/response/products_details_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/module_stores/response/products_category.dart';

@injectable
class ProductsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ProductsRepository(this._apiClient, this._authService);

  Future<ProductsDetailsResponse?> getProductsDetails(int id) async {
    dynamic response =
        await _apiClient.get(Urls.GET_PRODUCT_DETAILS_API + '/$id');
    if (response == null) return null;
    return ProductsDetailsResponse.fromJson(response);
  }


  Future<RateResponse?> createRateForProducts(RateStoreRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(Urls.RATE_PRODUCT, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return RateResponse.fromJson(response);
  }
}

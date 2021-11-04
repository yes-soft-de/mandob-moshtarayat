import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_home/response/best_store.dart';
import 'package:mandob_moshtarayat/module_home/response/products.dart';
import 'package:mandob_moshtarayat/module_home/response/store_categories.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_category_list.dart';

@injectable
class HomeRepository {
  final ApiClient _apiClient;
  HomeRepository(this._apiClient);
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
}

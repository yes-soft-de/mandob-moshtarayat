import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_stores/repository/store_products_repository.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/module_stores/response/products_by_category.dart';
import 'package:mandob_moshtarayat/module_stores/response/products_category.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_products.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_profile_response.dart';

@injectable
class StoreProductsManager {
  final StoreProductsRepository _storeProductsRepository;
  StoreProductsManager(this._storeProductsRepository);
  Future<StoreProfileResponse?> getStoreProfile(int id) =>
      _storeProductsRepository.getStoreProfile(id);
  Future<StoreProducts?> getStoreProducts(int id) =>
      _storeProductsRepository.getMostWantedProducts(id);
  Future<ProductsCategory?> getProductsCategory(int id) =>
      _storeProductsRepository.getCategories(id);
  Future<ProductsByCategory?> getProductsByCategory(int storeId, categoryId) =>
      _storeProductsRepository.getProductsByCategory(storeId, categoryId);
  Future<RateResponse?> rateStore(RateStoreRequest request) =>
      _storeProductsRepository.createRateForStore(request);
}

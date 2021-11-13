import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_products/repository/products_repository.dart';
import 'package:mandob_moshtarayat/module_products/response/products_details_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';

@injectable
class ProductsManager {
  final ProductsRepository _productsRepository;
  ProductsManager(this._productsRepository);
  Future<ProductsDetailsResponse?> getProductsDetails(int id) =>
      _productsRepository.getProductsDetails(id);

  Future<RateResponse?> rateProducts(RateStoreRequest request) =>
      _productsRepository.createRateForProducts(request);
}

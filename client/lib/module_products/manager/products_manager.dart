import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_products/repository/products_repository.dart';
import 'package:mandob_moshtarayat/module_products/request/products_request/products_request.dart';
import 'package:mandob_moshtarayat/module_products/response/cart_response/cart_response.dart';
import 'package:mandob_moshtarayat/module_products/response/products_details_response.dart';
import 'package:mandob_moshtarayat/module_products/response/products_similer_response/products_similer_response.dart';
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
  Future<ProductsSimilarResponse?> getProductsSimilar(int id) =>
      _productsRepository.getProductsSimilar(id);
  Future<CartResponse?> getCartValidation(ProductsRequest request) =>
      _productsRepository.getCartValidate(request);
}

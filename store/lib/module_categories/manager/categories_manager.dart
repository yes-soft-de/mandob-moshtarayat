import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_categories/repository/categories_repository.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/response/products_category_response.dart';
import 'package:mandob_moshtarayat/module_categories/response/response.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_categories_response.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_products_response.dart';

@injectable
class CategoriesManager {

  final CategoriesRepository _categoriesRepository;

  CategoriesManager(this._categoriesRepository);

  Future<StoreCategoriesResponse?> getStoreCategories() => _categoriesRepository.getStoreCategories();


  Future<ProductsCategoryResponse?> getCategoriesLevelOne() => _categoriesRepository.getCategoryLevelOne();
  Future<ProductsCategoryResponse?> getCategoriesLevelTwo(int id) => _categoriesRepository.getCategoryLevelTwo(id);

  Future<StoreProductsResponse?> getProductsLevelTwo(int id) => _categoriesRepository.getProductsLevelTwo(id);
  Future<StoreProductsResponse?> getProductsLevelOne(int id) => _categoriesRepository.getProductsLevelOne(id);
  Future<StoreProductsResponse?> getStoreProducts(String name) => _categoriesRepository.getStoreProducts(name);

  Future<ActionResponse?> createStoreProduct(CreateProductRequest request) => _categoriesRepository.createProduct(request);

  Future<ActionResponse?> updateProduct(UpdateProductRequest request) => _categoriesRepository.updateProduct(request);
  Future<ActionResponse?> updateProductStatus(UpdateProductStatusRequest request) => _categoriesRepository.updateProductStatus(request);
  Future<ActionResponse?> deleteProduct(String id) => _categoriesRepository.deleteProduct(id);


}

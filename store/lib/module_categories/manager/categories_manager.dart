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


  Future<ProductsCategoryResponse?> getProductCategoriesLevelOne(int id) => _categoriesRepository.getProductsCategoryLevelOne(id);
  Future<ProductsCategoryResponse?> getProductCategoriesLevelTwo(int id) => _categoriesRepository.getProductsCategoryLevelTwo(id);

  Future<StoreProductsResponse?> getProducts(int id) => _categoriesRepository.getProducts(id);
  Future<StoreProductsResponse?> getStoreProducts() => _categoriesRepository.getStoreProducts();

  Future<ActionResponse?> createStoreProduct(CreateProductRequest request) => _categoriesRepository.createProduct(request);

  Future<ActionResponse?> updateProduct(UpdateProductRequest request) => _categoriesRepository.updateProduct(request);


}

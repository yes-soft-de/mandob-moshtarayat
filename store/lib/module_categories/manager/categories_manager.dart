import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_categories/repository/categories_repository.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_products_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_store_category_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/store_categories_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_category_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_store_request.dart';
import 'package:mandob_moshtarayat/module_categories/response/products_category_response.dart';
import 'package:mandob_moshtarayat/module_categories/response/response.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_categories_response.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_products_response.dart';

@injectable
class CategoriesManager {

  final CategoriesRepository _categoriesRepository;

  CategoriesManager(this._categoriesRepository);

  Future<StoreCategoriesResponse?> getStoreCategories() => _categoriesRepository.getStoreCategories();

  Future<ActionResponse?> createCategory(CreateStoreCategoryRequest request) => _categoriesRepository.addCategory(request);

  Future<ProductsCategoryResponse?> getProductCategories(int id) => _categoriesRepository.getProductsCategory(id);

  Future<StoreProductsResponse?> getProducts(int id) => _categoriesRepository.getProducts(id);


  Future<ActionResponse?> createProductsCategory(CreateProductsCategoriesRequest request) => _categoriesRepository.createProductsCategory(request);

  Future<ActionResponse?> createStoreProduct(CreateProductRequest request) => _categoriesRepository.createProduct(request);

  Future<ActionResponse?> updateStoreCategories(UpdateStoreCategoriesRequest request) => _categoriesRepository.updateStoreCategories(request);

  Future<ActionResponse?> updateStore(UpdateStoreRequest request) => _categoriesRepository.updateStore(request);
  Future<ActionResponse?> updateProductCategory(UpdateProductCategoryRequest request) => _categoriesRepository.updateProductCategory(request);

  Future<ActionResponse?> updateProduct(UpdateProductRequest request) => _categoriesRepository.updateProduct(request);


}

import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/repository/categories_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/category_level_tow_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_products_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/create_store_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/filter_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/sub_categories_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_product_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/update_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/products_category_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_categories_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_products_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/sub_categories_response.dart';

@injectable
class CategoriesManager {
  final CategoriesRepository _categoriesRepository;

  CategoriesManager(this._categoriesRepository);

  Future<StoreCategoriesResponse?> getStoreCategories() =>
      _categoriesRepository.getStoreCategories();
  Future<StoreCategoriesResponse?> getStoreCategoriesWithLang(FilterLanguageCategoryRequest request) =>
      _categoriesRepository.getStoreCategoriesWithLang(request);
  Future<SubCategoriesResponse?> getSubCategories(FilterLanguageAndCategoryRequest request) =>
      _categoriesRepository.getSubcategoriesLevelOne(request);

  Future<SubCategoriesResponse?> getSubcategoriesLevelTow(FilterLanguageAndProductCategoryRequest id) =>
      _categoriesRepository.getSubcategoriesLevelTow(id);

  Future<ActionResponse?> createCategory(CreateStoreCategoryRequest request) =>
      _categoriesRepository.addCategory(request);

  Future<ProductsCategoryResponse?> getProductCategories(int id) =>
      _categoriesRepository.getProductsCategory(id);

  Future<StoreProductsResponse?> getProducts(int id) =>
      _categoriesRepository.getProducts(id);

  Future<ActionResponse?> createProductsCategory(
      CategoryLevelTowRequest request) =>
      _categoriesRepository.createProductsCategory(request);

  Future<ActionResponse?> createStoreProduct(CreateProductRequest request) =>
      _categoriesRepository.createProduct(request);

  Future<ActionResponse?> updateStoreCategories(
          UpdateStoreCategoriesRequest request) =>
      _categoriesRepository.updateStoreCategories(request);

  Future<ActionResponse?> updateStore(UpdateStoreRequest request) =>
      _categoriesRepository.updateStore(request);
  Future<ActionResponse?> updateProductCategory(
      CategoryLevelTowRequest request) =>
      _categoriesRepository.updateProductCategory(request);

  Future<ActionResponse?> updateProduct(UpdateProductRequest request) =>
      _categoriesRepository.updateProduct(request);
  Future<ActionResponse?> updateProductCommission(UpdateProductCommissionRequest request) =>
      _categoriesRepository.updateProductCommission(request);

  Future<ActionResponse?> createSubCategories(SubCategoriesRequest request) =>
      _categoriesRepository.createSubCategories(request);

  Future<ActionResponse?> updateSubCategories(SubCategoriesRequest request) =>
      _categoriesRepository.updateSubCategories(request);
      
  Future<ActionResponse?> deleteCategories(String id) =>
      _categoriesRepository.deleteCategories(id);
      
Future<ActionResponse?> deleteSubCategories(String id) =>
      _categoriesRepository.deleteSubCategories(id);
}

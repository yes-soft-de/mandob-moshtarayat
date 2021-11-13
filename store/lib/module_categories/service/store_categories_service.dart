import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/manager/categories_manager.dart';
import 'package:mandob_moshtarayat/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
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
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class CategoriesService {

  final CategoriesManager _categoriesManager;

  CategoriesService(this._categoriesManager);

  Future<DataModel> getStoreCategories() async {

    StoreCategoriesResponse? _ordersResponse = await _categoriesManager.getStoreCategories();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return StoreCategoriesModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> createCategory(CreateStoreCategoryRequest request) async {
    ActionResponse? actionResponse =

    await _categoriesManager.createCategory(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getProductsCategoryLevelOne(int id) async {

    ProductsCategoryResponse? _productCategories = await _categoriesManager.getProductCategoriesLevelOne(id);
    if (_productCategories == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_productCategories.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_productCategories.statusCode));
    }
    if (_productCategories.data == null) return DataModel.empty();

    return ProductsCategoryModel.withData(_productCategories.data!);
  }
  Future<DataModel> getProductsCategoryLevelTwo(int id) async {

    ProductsCategoryResponse? _productCategories = await _categoriesManager.getProductCategoriesLevelTwo(id);
    if (_productCategories == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_productCategories.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_productCategories.statusCode));
    }
    if (_productCategories.data == null) return DataModel.empty();

    return ProductsCategoryModel.withData(_productCategories.data!);
  }
  Future<DataModel> getProducts(int id) async {

    StoreProductsResponse? _productCategories = await _categoriesManager.getProducts(id);
    if (_productCategories == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_productCategories.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_productCategories.statusCode));
    }
    if (_productCategories.data == null) return DataModel.empty();

    return ProductsModel.withData(_productCategories.data!);
  }

  Future<DataModel> createProductCategories(CreateProductsCategoriesRequest request) async {
    ActionResponse? actionResponse =

    await _categoriesManager.createProductsCategory(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }
  Future<DataModel> createProduct(CreateProductRequest request) async {
    ActionResponse? actionResponse =

    await _categoriesManager.createStoreProduct(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateStoreCategory(UpdateStoreCategoriesRequest request) async {
    ActionResponse? actionResponse =
    await _categoriesManager.updateStoreCategories(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }
  Future<DataModel> updateStore(UpdateStoreRequest request) async {
    ActionResponse? actionResponse =
    await _categoriesManager.updateStore(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }
  Future<DataModel> updateProductCategory(UpdateProductCategoryRequest request) async {
    ActionResponse? actionResponse =
    await _categoriesManager.updateProductCategory(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }
  Future<DataModel> updateProduct(UpdateProductRequest request) async {
    ActionResponse? actionResponse =
    await _categoriesManager.updateProduct(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }

}

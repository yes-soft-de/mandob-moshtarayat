import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/manager/categories_manager.dart';
import 'package:mandob_moshtarayat/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
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


  Future<DataModel> getCategoryLevelOne() async {

    ProductsCategoryResponse? _productCategories = await _categoriesManager.getCategoriesLevelOne();
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
  Future<DataModel> getCategoryLevelTwo(int id) async {

    ProductsCategoryResponse? _productCategories = await _categoriesManager.getCategoriesLevelTwo(id);
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

  Future<DataModel> getProductsLevelTwo(int id) async {

    StoreProductsResponse? _productCategories = await _categoriesManager.getProductsLevelTwo(id);
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
  Future<DataModel> getStoreProducts(String name) async {

    StoreProductsResponse? _productCategories = await _categoriesManager.getStoreProducts(name);
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

  Future<DataModel> updateProduct(UpdateProductRequest request) async {
    ActionResponse? actionResponse =
    await _categoriesManager.updateProduct(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }


  Future<DataModel> getProductsLevelOne(int id) async {

    StoreProductsResponse? _productCategories = await _categoriesManager.getProductsLevelOne(id);
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

  Future<DataModel> updateProductStatus(UpdateProductStatusRequest request) async {
    ActionResponse? actionResponse =
    await _categoriesManager.updateProductStatus(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }

}

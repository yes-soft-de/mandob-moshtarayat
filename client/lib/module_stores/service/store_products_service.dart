import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat/module_orders/model/deleted_order_status.dart';
import 'package:mandob_moshtarayat/module_stores/manager/store_products.dart';
import 'package:mandob_moshtarayat/module_stores/model/category_model.dart';
import 'package:mandob_moshtarayat/module_stores/model/store_products_model.dart';
import 'package:mandob_moshtarayat/module_stores/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/module_stores/response/products_by_category.dart';
import 'package:mandob_moshtarayat/module_stores/response/products_category.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_products.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_profile_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';
import 'package:mandob_moshtarayat/utils/models/product.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';
import 'package:translator/translator.dart';

@injectable
class StoreProductsService {
  final StoreProductsManager _storeProductsManager;

  StoreProductsService(this._storeProductsManager);

  Future<StoreModel> getStoreProfile(int id) async {
    StoreProfileResponse? storeProfileResponse =
        await _storeProductsManager.getStoreProfile(id);
    if (storeProfileResponse == null) {
      return StoreModel.Error(S.current.networkError);
    }
    if (storeProfileResponse.statusCode != '200') {
      return StoreModel.Error(StatusCodeHelper.getStatusCodeMessages(
          storeProfileResponse.statusCode));
    }
    if (storeProfileResponse.data == null) return StoreModel.Empty();
    return StoreProfile.withData(storeProfileResponse.data!);
  }

  Future<ProductModel> getStoresProductsTopWanted(int id) async {
    StoreProducts? storeProducts =
        await _storeProductsManager.getStoreProducts(id);
    if (storeProducts == null) {
      return ProductModel.Error(S.current.networkError);
    }
    if (storeProducts.statusCode != '200') {
      return ProductModel.Error(
          StatusCodeHelper.getStatusCodeMessages(storeProducts.statusCode));
    }
    if (storeProducts.data == null) return ProductModel.Empty();
    return ProductModel.topWantedData(storeProducts);
  }

  Future<CategoryModel> getProductsCategory(int id) async {
    ProductsCategory? productsCategory =
        await _storeProductsManager.getProductsCategory(id);
    if (productsCategory == null) {
      return CategoryModel.Error(S.current.networkError);
    }
    if (productsCategory.statusCode != '200') {
      return CategoryModel.Error(
          StatusCodeHelper.getStatusCodeMessages(productsCategory.statusCode));
    }
    if (productsCategory.data == null) return CategoryModel.Empty();
    return CategoryModel.Data(productsCategory);
  }

  Future<ProductModel> getProductsByCategory(
      int storeId, int categoryId) async {
    ProductsByCategory? productsByCategory =
        await _storeProductsManager.getProductsByCategory(storeId, categoryId);
    if (productsByCategory == null) {
      return ProductModel.Error(S.current.networkError);
    }
    if (productsByCategory.statusCode != '200') {
      return ProductModel.Error(StatusCodeHelper.getStatusCodeMessages(
          productsByCategory.statusCode));
    }
    if (productsByCategory.data == null) return ProductModel.Empty();
     for (var element in productsByCategory.data!) {
      element.productName = await translateService(element.productName ?? '');
    }
    return ProductModel.Data(productsByCategory);
  }

  Future<StoreProductsData> getProductsData(int id) async {
    var topWanted = await getStoresProductsTopWanted(id);
    var cats = await getProductsCategory(id);
    List<String> errors = [];
    if (topWanted.hasError) {
      errors.add(topWanted.error!);
    }
    if (cats.hasError) {
      errors.add(cats.error!);
    }
    if (errors.isNotEmpty && errors.length == 2) {
      return StoreProductsData.Error(errors);
    }
    if (topWanted.isEmpty && cats.isEmpty) {
      return StoreProductsData.Empty();
    }
    for (var element in topWanted.data) {
      element.title = await translateService(element.title);
    }
    return StoreProductsData.Data(topWanted.data, cats.data, errors);
  }

  Future<MyOrderState> rateStore(RateStoreRequest request) async {
    RateResponse? rateStoreResponse =
        await _storeProductsManager.rateStore(request);
    if (rateStoreResponse == null) {
      return MyOrderState.error(S.current.networkError);
    }
    if (rateStoreResponse.statusCode != '201') {
      return MyOrderState.error(
          StatusCodeHelper.getStatusCodeMessages(rateStoreResponse.statusCode));
    }
    return MyOrderState.empty();
  }

  Future<String> translateService(String word) async {
    var reg = RegExp(
        r'[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]');
    if (reg.hasMatch(word) &&
        getIt<LocalizationService>().getLanguage() == 'ar') {
      return word;
    }
    final translator = GoogleTranslator();
    var translation = await translator.translate(word,
        to: getIt<LocalizationService>().getLanguage());
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print('source ${translation.source} translated to ${translation.text}');
    print(
        'source ${translation.sourceLanguage} target ${translation.targetLanguage}');
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');

    return translation.text;
  }
}

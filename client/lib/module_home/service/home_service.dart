import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/manager/home_manager.dart';
import 'package:mandob_moshtarayat/module_home/model/favorite_categories_model.dart';
import 'package:mandob_moshtarayat/module_home/model/home_model.dart';
import 'package:mandob_moshtarayat/module_home/model/products_by_categories_model.dart';
import 'package:mandob_moshtarayat/module_home/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat/module_home/model/top_wanted_products_model.dart';
import 'package:mandob_moshtarayat/module_home/response/favorite_response/favorite_response.dart';
import 'package:mandob_moshtarayat/module_home/response/products.dart';
import 'package:mandob_moshtarayat/module_home/response/products_by_categories_response.dart';
import 'package:mandob_moshtarayat/module_home/response/store_categories.dart';
import 'package:mandob_moshtarayat/module_home/response/sub_categories_response.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_category_list.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';
import 'package:translator/translator.dart';

@injectable
class HomeService {
  final HomeManager _homeManager;

  HomeService(this._homeManager);

  Future<TopWantedProductsModel> getTopProducts() async {
    ProductsResponse? topProducts = await _homeManager.getTopProducts();
    if (topProducts == null) {
      return TopWantedProductsModel.Error(S.current.networkError);
    }
    if (topProducts.statusCode != '200') {
      return TopWantedProductsModel.Error(
          StatusCodeHelper.getStatusCodeMessages(
              topProducts.statusCode ?? '0'));
    }
    if (topProducts.data == null) return TopWantedProductsModel.Empty();

    return TopWantedProductsModel.Data(topProducts);
  }

  Future<StoreCategoryModel> getStoreCategories() async {
    StoreCategoriesResponse? storeCategories =
        await _homeManager.getStoreCategories();

    if (storeCategories == null) {
      return StoreCategoryModel.Error(S.current.networkError);
    }
    if (storeCategories.statusCode != '200') {
      return StoreCategoryModel.Error(StatusCodeHelper.getStatusCodeMessages(
          storeCategories.statusCode ?? '0'));
    }
    if (storeCategories.data == null) return StoreCategoryModel.Empty();

    return StoreCategoryModel.Data(storeCategories);
  }

  Future<StoreModel> getBestStores() async {
    StoreCategoryList? bestStores = await _homeManager.getBestStores();
    if (bestStores == null) return StoreModel.Error(S.current.networkError);
    if (bestStores.statusCode != '200') {
      return StoreModel.Error(
          StatusCodeHelper.getStatusCodeMessages(bestStores.statusCode ?? '0'));
    }
    if (bestStores.data == null) return StoreModel.Empty();

    return StoreModel.Data(bestStores);
  }

  Future<HomeModel> getHomeData() async {
    var storeCategories = await getStoreCategories();
    var favoriteCategories = await getFavoriteCategories();

    List<String> errors = [];

    if (favoriteCategories.hasError) {
      errors.add(favoriteCategories.error!);
    }
    if (storeCategories.hasError) {
      errors.add(storeCategories.error!);
    }
    if (errors.isNotEmpty && errors.length == 2) {
      return HomeModel.Error(errors);
    }
    if (favoriteCategories.isEmpty && storeCategories.isEmpty) {
      return HomeModel.Empty();
    }
    if (favoriteCategories.hasError || favoriteCategories.isEmpty) {
      var favs = <FavoriteCategoriesModel>[];
      return HomeModel.Data(favs, storeCategories.data, errors);
    }
    favoriteCategories as FavoriteCategoriesModel;
    return HomeModel.Data(
        favoriteCategories.data, storeCategories.data, errors);
  }

  Future<DataModel> getSubCategories(String categoriesID) async {
    SubCategoriesResponse? subCategoriesResponse =
        await _homeManager.getSubCategories(categoriesID);
    if (subCategoriesResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (subCategoriesResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          subCategoriesResponse.statusCode ?? '0'));
    }
    if (subCategoriesResponse.data == null) return DataModel.empty();
    return SubCategoriesModel.withData(subCategoriesResponse.data!);
  }

  Future<DataModel> getCategoriesProducts(String categoriesID) async {
    ProductsByCategoriesResponse? productsResponse =
        await _homeManager.getCategoriesProducts(categoriesID);
    if (productsResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (productsResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          productsResponse.statusCode ?? '0'));
    }
    if (productsResponse.data == null) return DataModel.empty();
    for (var element in productsResponse.data!) {
      element.productName = await translateService(element.productName ?? '');
    }
    return ProductsByCategoriesModel.withData(productsResponse.data!);
  }

  Future<DataModel> getSubCategoriesProducts(String categoriesID) async {
    ProductsByCategoriesResponse? productsResponse =
        await _homeManager.getSubCategoriesProducts(categoriesID);
    if (productsResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (productsResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          productsResponse.statusCode ?? '0'));
    }
    if (productsResponse.data == null) return DataModel.empty();
    for (var element in productsResponse.data!) {
      element.productName = await translateService(element.productName ?? '');
    }
    return ProductsByCategoriesModel.withData(productsResponse.data!);
  }

  Future<DataModel> getMainCategoryProducts(String categoriesID) async {
    ProductsByCategoriesResponse? productsResponse =
        await _homeManager.getMainCategoryProducts(categoriesID);
    if (productsResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (productsResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          productsResponse.statusCode ?? '0'));
    }
    if (productsResponse.data == null) return DataModel.empty();
    for (var element in productsResponse.data!) {
      element.productName = await translateService(element.productName ?? '');
    }
    return ProductsByCategoriesModel.withData(productsResponse.data!);
  }

  Future<DataModel> getFavoriteCategories() async {
    FavoriteResponse? favoriteResponse =
        await _homeManager.getFavoriteCategories();
    if (favoriteResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (favoriteResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          favoriteResponse.statusCode ?? '0'));
    }
    if (favoriteResponse.data == null) return DataModel.empty();
    return FavoriteCategoriesModel.withData(favoriteResponse.data!);
  }

  Future<DataModel> getProductsByStore(String storeID) async {
    ProductsByCategoriesResponse? productsResponse =
        await _homeManager.getProductsByStore(storeID);
    if (productsResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (productsResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          productsResponse.statusCode ?? '0'));
    }
    if (productsResponse.data == null) return DataModel.empty();
    for (var element in productsResponse.data!) {
      element.productName = await translateService(element.productName ?? '');
    }
    return ProductsByCategoriesModel.withData(productsResponse.data!);
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
    print('source ${translation.sourceLanguage} target ${translation.targetLanguage}');
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');

    return translation.text;
  }
}

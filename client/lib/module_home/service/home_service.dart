import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/manager/home_manager.dart';
import 'package:mandob_moshtarayat/module_home/model/home_model.dart';
import 'package:mandob_moshtarayat/module_home/model/top_wanted_products_model.dart';
import 'package:mandob_moshtarayat/module_home/response/best_store.dart';
import 'package:mandob_moshtarayat/module_home/response/products.dart';
import 'package:mandob_moshtarayat/module_home/response/store_categories.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_category_list.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';

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
    var top = await getTopProducts();
    var storeCategories = await getStoreCategories();
    var bestStores = await getBestStores();
    List<String> errors = [];
    if (top.hasError) {
      errors.add(top.error!);
    }
    if (storeCategories.hasError) {
      errors.add(storeCategories.error!);
    }
    if (bestStores.hasError) {
      errors.add(bestStores.error!);
    }
    if (errors.isNotEmpty && errors.length == 3) {
      return HomeModel.Error(errors);
    }
    if (top.isEmpty && storeCategories.isEmpty && bestStores.isEmpty) {
      return HomeModel.Empty();
    }
    return HomeModel.Data(
        top.data, bestStores.data, storeCategories.data, errors);
  }
}

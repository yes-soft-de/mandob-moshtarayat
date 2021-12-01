import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_home/repository/home_repository.dart';
import 'package:mandob_moshtarayat/module_home/response/favorite_response/favorite_response.dart';
import 'package:mandob_moshtarayat/module_home/response/products.dart';
import 'package:mandob_moshtarayat/module_home/response/products_by_categories_response.dart';
import 'package:mandob_moshtarayat/module_home/response/store_categories.dart';
import 'package:mandob_moshtarayat/module_home/response/sub_categories_response.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_category_list.dart';

@injectable
class HomeManager {
  final HomeRepository _homeRepository;
  HomeManager(this._homeRepository);
  Future<ProductsResponse?> getTopProducts() =>
      _homeRepository.getTopProducts();
  Future<StoreCategoriesResponse?> getStoreCategories() =>
      _homeRepository.getStoreCategories();
  Future<StoreCategoryList?> getBestStores() => _homeRepository.getBestStores();
  Future<SubCategoriesResponse?> getSubCategories(String categoriesID) =>
      _homeRepository.getSubCategories(categoriesID);
  Future<ProductsByCategoriesResponse?> getCategoriesProducts(
          String categoriesID) =>
      _homeRepository.getCategoriesProducts(categoriesID);
  Future<ProductsByCategoriesResponse?> getSubCategoriesProducts(
          String categoriesID) =>
      _homeRepository.getSubCategoriesProducts(categoriesID);
  Future<ProductsByCategoriesResponse?> getMainCategoryProducts(
          String categoriesID) =>
      _homeRepository.getMainCategoryProducts(categoriesID);
        Future<FavoriteResponse?> getFavoriteCategories() =>
      _homeRepository.getFavoriteCategories();
}

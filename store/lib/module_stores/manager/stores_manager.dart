import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_stores/repository/stores_repository.dart';
import 'package:mandob_moshtarayat/module_stores/response/products.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_categories.dart';

@injectable
class StoresManager {
  final StoresRepository _storesRepository;
  StoresManager(this._storesRepository);
  Future<StoreAndCategoriesResponse?> getCategoriesAndStores() =>
      _storesRepository.getCategoriesAndStores();
  Future<ProductsResponse?> getLastProducts() =>
      _storesRepository.getLastProducts();

//  Future<StoreCategoriesResponse?> getStoreCategories() =>
//      _homeRepository.getStoreCategories();
//  Future<StoreCategoryList?> getBestStores() => _homeRepository.getBestStores();
//  Future<SubCategoriesResponse?> getSubCategories(String categoriesID) => _homeRepository.getSubCategories(categoriesID);
//  Future<ProductsByCategoriesResponse?> getCategoriesProducts(String categoriesID) => _homeRepository.getCategoriesProducts(categoriesID);
//  Future<ProductsByCategoriesResponse?> getSubCategoriesProducts(String categoriesID) => _homeRepository.getSubCategoriesProducts(categoriesID);
//  Future<ProductsByCategoriesResponse?> getMainCategoryProducts(String categoriesID) => _homeRepository.getMainCategoryProducts(categoriesID);

}

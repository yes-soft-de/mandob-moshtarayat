import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/request/filter_category_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_categories_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/sub_categories_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/repository/linking_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/main_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/response/store_categories_linking_response/store_categories_linking_response.dart';

@injectable
class LinkingManager {
  final LinkingRepository _categoriesRepository;

  LinkingManager(this._categoriesRepository);

  Future<StoreCategoriesLinkingResponse?> getStoreCategories(String id) =>
      _categoriesRepository.getStoreCategories(id);

  Future<SubCategoriesResponse?> getSubCategories() =>
      _categoriesRepository.getSubcategoriesLevelOne();

  Future<SubCategoriesResponse?> getSubCategoriesLinking() =>
      _categoriesRepository.getSubCategoriesLinking();

  Future<SubCategoriesResponse?> getSubcategoriesLevelTow() =>
      _categoriesRepository.getSubcategoriesLevelTow();
  Future<ActionResponse?> updateMainLink(MainLinkRequest request) =>
      _categoriesRepository.updateMainLink(request);
}

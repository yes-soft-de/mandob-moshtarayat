import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_categories_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/sub_categories_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/manager/linking_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/model/store_categories_link_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/request/main_link_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/response/store_categories_linking_response/store_categories_linking_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class LinkingService {
  final LinkingManager _categoriesManager;

  LinkingService(this._categoriesManager);

  Future<DataModel> getStoreCategories(String id) async {
    StoreCategoriesLinkingResponse? _ordersResponse =
        await _categoriesManager.getStoreCategories(id);
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return StoreCategoriesLinksModel.withData(_ordersResponse.data!);
  }

//////////////////////////////////////////////////////////////

  Future<DataModel> getSubCategories() async {
    SubCategoriesResponse? _ordersResponse =
        await _categoriesManager.getSubCategories();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return SubCategoriesModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> getSubCategoriesLinking() async {
    SubCategoriesResponse? _ordersResponse =
        await _categoriesManager.getSubCategoriesLinking();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return SubCategoriesModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> getSubcategoriesLevelTow() async {
    SubCategoriesResponse? _ordersResponse =
        await _categoriesManager.getSubcategoriesLevelTow();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return SubCategoriesModel.withData(_ordersResponse.data!);
  }
   Future<DataModel> updateMainLink(MainLinkRequest request) async {
    ActionResponse? _ordersResponse =
        await _categoriesManager.updateMainLink(request);
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    return DataModel.empty();
  }
}

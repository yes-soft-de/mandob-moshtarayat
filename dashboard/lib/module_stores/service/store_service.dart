import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/manager/stores_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/store_balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/store_profile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/stores_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/request/create_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/response/store_balance_response/store_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/response/store_profile_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/response/stores_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class StoresService {
  final StoreManager _storeManager;

  StoresService(this._storeManager);

  Future<DataModel> getStores() async {
    StoresResponse? _storesResponse = await _storeManager.getStores();
    if (_storesResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storesResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storesResponse.statusCode));
    }
    if (_storesResponse.data == null) return DataModel.empty();
    return StoresModel.withData(_storesResponse.data!);
  }

  Future<DataModel> getStoresInActive() async {
    StoresResponse? _storesResponse = await _storeManager.getStoresInActive();
    if (_storesResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storesResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storesResponse.statusCode));
    }
    if (_storesResponse.data == null) return DataModel.empty();
    return StoresModel.withData(_storesResponse.data!);
  }

  Future<DataModel> getStoresInActiveFilter(String searchKey) async {
    StoresResponse? _storesResponse =
        await _storeManager.getStoresInActiveFilter(searchKey);
    if (_storesResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storesResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storesResponse.statusCode));
    }
    if (_storesResponse.data == null) return DataModel.empty();
    return StoresModel.withData(_storesResponse.data!);
  }

  Future<DataModel> getStoreProfile(int id) async {
    StoreProfileResponse? _storeResponse =
        await _storeManager.getStoreProfile(id);
    if (_storeResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storeResponse.statusCode));
    }
    if (_storeResponse.data == null) return DataModel.empty();
    return StoreProfileModel.withData(_storeResponse.data!);
  }

  Future<DataModel> createStores(CreateStoreRequest request) async {
    ActionResponse? actionResponse = await _storeManager.createStore(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getStoreBalance(int id) async {
    StoreBalanceResponse? _storeResponse =
        await _storeManager.getStoreAccountBalance(id);
    if (_storeResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storeResponse.statusCode));
    }
    if (_storeResponse.data == null) return DataModel.empty();
    return StoreBalanceModel.withData(_storeResponse.data!);
  }
}

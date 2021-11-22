import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/repository/stores_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/request/create_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/response/store_profile_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/response/stores_response.dart';

@injectable
class StoreManager {
  final StoresRepository _storesRepository;

  StoreManager(this._storesRepository);

  Future<StoresResponse?> getStores() => _storesRepository.getStores();
  Future<StoresResponse?> getStoresInActive() =>
      _storesRepository.getStoresInActive();
  Future<StoresResponse?> getStoresInActiveFilter(String searchKey) =>
      _storesRepository.getStoresFilter(searchKey);
  Future<StoreProfileResponse?> getStoreProfile(int id) =>
      _storesRepository.getStoreProfile(id);
  Future<ActionResponse?> createStore(CreateStoreRequest request) =>
      _storesRepository.addStore(request);
}

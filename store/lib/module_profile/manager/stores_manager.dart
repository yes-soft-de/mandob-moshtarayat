import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_categories/response/response.dart';
import 'package:mandob_moshtarayat/module_profile/repository/stores_repository.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/module_profile/response/store_profile_response.dart';

@injectable
class StoreManager {

  final StoresRepository _storesRepository;

  StoreManager(this._storesRepository);

  Future<StoreProfileResponse?> getStoreProfile() => _storesRepository.getStoreProfile();
  Future<ActionResponse?> updateStore(CreateStoreRequest request) => _storesRepository.updateStore(request);

}

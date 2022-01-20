import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_stores/repository/store_repository.dart';

@injectable
class StoreManager {

  final StoreRepository _storesRepository;

  StoreManager(this._storesRepository);

//  Future<ProfileResponse?> getProfile() => _storesRepository.getProfile();
//  Future<ActionResponse?> updateStore(CreateMandobRequest request) => _storesRepository.updateProfile(request);

}

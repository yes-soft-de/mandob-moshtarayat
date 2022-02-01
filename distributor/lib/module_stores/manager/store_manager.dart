import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_stores/repository/store_repository.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_response.dart';

@injectable
class StoreManager {

  final StoreRepository _storesRepository;

  StoreManager(this._storesRepository);

  Future<StoreResponse?> getStores() => _storesRepository.getStores();
}

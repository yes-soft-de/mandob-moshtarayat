import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_stores/repository/store_list_repository.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_category_list.dart';

@injectable
class StoreListManager {
  StoreListRepository _storeListRepository;
  StoreListManager(this._storeListRepository);
  Future<StoreCategoryList?> getStoresCategoryList(int id) =>
      _storeListRepository.getStoreList(id);
}

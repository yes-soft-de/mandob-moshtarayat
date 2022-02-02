import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_stores/manager/store_list_manager.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_category_list.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';

@injectable
class StoreListService {
  final StoreListManager _storeListManager;

  StoreListService(this._storeListManager);

  Future<StoreModel> getStoresList(int id) async {
    StoreCategoryList? storeCategoryList =
        await _storeListManager.getStoresCategoryList(id);
    if (storeCategoryList == null)
      return StoreModel.Error(S.current.networkError);
    if (storeCategoryList.statusCode != '200') {
      return StoreModel.Error(StatusCodeHelper.getStatusCodeMessages(
          storeCategoryList.statusCode ?? '0'));
    }
    if (storeCategoryList.data == null) return StoreModel.Empty();

    return StoreModel.Data(storeCategoryList);
  }
}

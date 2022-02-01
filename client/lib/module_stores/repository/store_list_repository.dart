import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_category_list.dart';

@injectable
class StoreListRepository {
  final ApiClient _apiClient;
  StoreListRepository(this._apiClient);
  Future<StoreCategoryList?> getStoreList(int id) async {
    dynamic response =
        await _apiClient.get(Urls.GET_STORE_CATEGORY_LIST_API + '$id');
    if (response == null) return null;
    return StoreCategoryList.fromJson(response);
  }
}

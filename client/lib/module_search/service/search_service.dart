import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_search/manager/search_manager.dart';
import 'package:mandob_moshtarayat/module_search/model/search_model.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class SearchService {
  final SearchManager _manager;

  SearchService(this._manager);

  Future<SearchModel> getStoresList(String key) async {
    var searchResult = await _manager.getStoresCategoryList(key);
    if (searchResult == null) return SearchModel.Error(S.current.networkError);
    if (searchResult.statusCode != '200') {
      return SearchModel.Error(StatusCodeHelper.getStatusCodeMessages(
          searchResult.statusCode ?? '0'));
    }
    if (searchResult.data == null) return SearchModel.Empty();

    return SearchModel.Data(searchResult.data!);
  }
}

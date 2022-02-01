import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/module_search/response/search_response.dart';

@injectable
class SearchRepository {
  final ApiClient _apiClient;
  SearchRepository(this._apiClient);
  Future<SearchResponse?> getSearchResult(String key) async {
    dynamic response = await _apiClient.get(Urls.GET_SEARCH_RESULT + '$key');
    if (response == null) return null;
    return SearchResponse.fromJson(response);
  }
}

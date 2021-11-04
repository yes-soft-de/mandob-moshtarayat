import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_search/service/search_service.dart';
import 'package:mandob_moshtarayat/module_search/ui/screen/search_screen.dart';
import 'package:mandob_moshtarayat/module_search/ui/state/store_list/search_error_state.dart';
import 'package:mandob_moshtarayat/module_search/ui/state/store_list/search_loaded_state.dart';
import 'package:mandob_moshtarayat/module_search/ui/state/store_list/search_loading_state.dart';
import 'package:mandob_moshtarayat/module_search/ui/state/store_list/search_state.dart';
import 'package:mandob_moshtarayat/module_search/ui/state/store_list/search_empty_state.dart';

@injectable
class SearchStateManager {
  final SearchService _searchService;
  final PublishSubject<SearchState> _stateSubject = PublishSubject();

  Stream<SearchState> get stateStream => _stateSubject.stream;

  SearchStateManager(this._searchService);

  void getSearchResult(String key, SearchScreenState screenState) {
    if (key.trim().isEmpty) {
      _stateSubject.add(SearchEmptyState(screenState, ''));
    } else {
      _searchService.getStoresList(key).then((value) {
        if (value.isEmpty) {
          _stateSubject
              .add(SearchEmptyState(screenState, S.current.homeDataEmpty));
        } else if (value.hasError) {
          _stateSubject.add(SearchErrorState(screenState, value.error));
        } else {
          _stateSubject.add(SearchLoadedState(screenState, value.data));
        }
      });
    }
  }
}

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_stores/service/store_list_service.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_list_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_list/store_list_error_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_list/store_list_loaded_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_list/store_list_loading_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_list/store_list_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_list/store_lit_empty_state.dart';

@injectable
class StoreListStateManager {
  final StoreListService _storeListService;
  final PublishSubject<StoreListState> _stateSubject = PublishSubject();
  Stream<StoreListState> get stateStream => _stateSubject.stream;
  StoreListStateManager(this._storeListService);
  void getStoresCategoryList(int id, StoreListScreenState screenState) {
    _stateSubject.add(StoreListLoadingState(screenState));
    _storeListService.getStoresList(id).then((value) {
      if (value.empty) {
        _stateSubject
            .add(StoreListEmptyState(screenState, S.current.homeDataEmpty, id));
      } else if (value.hasError) {
        _stateSubject.add(StoreListErrorState(screenState, value.error!, id));
      } else {
        _stateSubject.add(StoreListLoadedState(screenState, value.data));
      }
    });
  }
}

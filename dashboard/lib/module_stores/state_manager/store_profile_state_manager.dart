import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/store_profile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/service/store_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/screen/store_info_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_profile/store_profile_loaded_state.dart';

@injectable
class StoreProfileStateManager {
  final StoresService _storesService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreProfileStateManager(this._storesService);

  void getStore(StoreInfoScreenState screenState, int id) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.getStoreProfile(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            StoreProfileLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(StoreProfileLoadedState(screenState, null, empty: true));
      } else {
        StoreProfileModel model = value as StoreProfileModel;
        _stateSubject.add(StoreProfileLoadedState(screenState, model.data));
      }
    });
  }
}

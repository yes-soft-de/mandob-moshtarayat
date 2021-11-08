import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/service/store_service.dart';
import 'package:mandob_moshtarayat/module_profile/ui/screen/store_info_screen.dart';
import 'package:mandob_moshtarayat/module_profile/ui/state/store_profile/store_profile_loaded_state.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class StoreProfileStateManager {
  final StoresService _storesService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreProfileStateManager(this._storesService);

  void getStore(StoreInfoScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.getStoreProfile().then((value) {
      if (value.hasError) {
        _stateSubject.add(StoreProfileLoadedState(screenState,null,error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(StoreProfileLoadedState(screenState,null,empty:true));
      } else {
        StoreProfileModel model = value as StoreProfileModel;
        _stateSubject.add(StoreProfileLoadedState(screenState,model.data));
      }
    });
  }

}

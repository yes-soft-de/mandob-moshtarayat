import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service.dart';
import 'package:mandob_moshtarayat/module_stores/model/store_model.dart';
import 'package:mandob_moshtarayat/module_stores/service/store_service.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/store_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/store_loaded_state.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class StoreStateManager {
  final StoreService _storeService;
  final ImageUploadService _uploadService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreStateManager(this._storeService, this._uploadService, this._authService);

  void getStore(StoreScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _storeService.getStores().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            StoreLoadedState(screenState, [], error: value.error));
      }
      if (value.isEmpty) {
        _stateSubject.add(StoreLoadedState(screenState, [], empty: true));
      }
      StoreModel model = value as StoreModel;
      _stateSubject.add(StoreLoadedState(screenState, model.data));
    });
  }
}

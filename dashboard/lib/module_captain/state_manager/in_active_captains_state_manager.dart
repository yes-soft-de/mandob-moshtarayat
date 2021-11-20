import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/inActiveModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/service/captains_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/in_active_captains_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/state/in_active/in_active_captains_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/StoreCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/stores_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/request/create_store_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/service/store_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

@injectable
class InActiveCaptainsStateManager {
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;
  InActiveCaptainsScreenState? _captainsScreenState;
  InActiveCaptainsScreenState? get state => _captainsScreenState;

  InActiveCaptainsStateManager(this._captainsService);

  void getCaptains(InActiveCaptainsScreenState screenState) {
    _captainsScreenState = screenState;
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getInActiveCaptains().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            InCaptainActiveLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(InCaptainActiveLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        InActiveModel _model = value as InActiveModel;
        _stateSubject.add(InCaptainActiveLoadedState(screenState, _model.data));
      }
    });
  }
}

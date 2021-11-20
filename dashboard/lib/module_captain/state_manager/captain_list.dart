import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/inActiveModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/service/captains_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/screen/captains_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/ui/state/captain_list/captains_loaded_state.dart';

@injectable
class CaptainsStateManager {
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();
  CaptainsScreenState? _captainsScreenState;
  Stream<States> get stateStream => _stateSubject.stream;
  CaptainsScreenState? get state => _captainsScreenState;

  CaptainsStateManager(this._captainsService);

  void getCaptains(CaptainsScreenState screenState) {
    _captainsScreenState = screenState;
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getCaptains().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(CaptainsLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(CaptainsLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        InActiveModel _model = value as InActiveModel;
        _stateSubject.add(CaptainsLoadedState(screenState, _model.data));
      }
    });
  }
}

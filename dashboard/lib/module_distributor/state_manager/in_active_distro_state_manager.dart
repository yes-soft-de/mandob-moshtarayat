import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/inActiveModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/service/distributer_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/in_active_distros_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/state/in_active_distros/in_active_distributors_loaded_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';

@injectable
class InActiveDistributorsStateManager {
  final DistributerService _distroService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;
  InActiveDistributorsScreenState? _captainsScreenState;
  InActiveDistributorsScreenState? get state => _captainsScreenState;

  InActiveDistributorsStateManager(this._distroService);

  void getDistros(InActiveDistributorsScreenState screenState) {
    _captainsScreenState = screenState;
    _stateSubject.add(LoadingState(screenState));
    _distroService.getInActiveDistros().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            InDistributedActiveLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(InDistributedActiveLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        DistributorModel _model = value as DistributorModel;
        _stateSubject.add(InDistributedActiveLoadedState(screenState, _model.data));
      }
    });
  }
}

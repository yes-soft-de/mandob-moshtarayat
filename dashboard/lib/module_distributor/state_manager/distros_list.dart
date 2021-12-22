import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/inActiveModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/service/distributer_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distors_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/state/distros_list/distros_loaded_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';

@injectable
class DistrosStateManager {
  final DistributerService _distrosService;
  final PublishSubject<States> _stateSubject = PublishSubject();
  DistrosScreenState? _captainsScreenState;
  Stream<States> get stateStream => _stateSubject.stream;
  DistrosScreenState? get state => _captainsScreenState;

  DistrosStateManager(this._distrosService);

  void getDistros(DistrosScreenState screenState) {
    _captainsScreenState = screenState;
    _stateSubject.add(LoadingState(screenState));
    _distrosService.getDistros().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(DistrosLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(DistrosLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        DistributorModel _model = value as DistributorModel;
        _stateSubject.add(DistrosLoadedState(screenState, _model.data));
      }
    });
  }
}

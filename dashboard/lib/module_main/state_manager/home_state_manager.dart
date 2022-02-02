import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_main/model/report_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_main/sceen/home_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_main/sceen/home_state/home_state_loaded.dart';
import 'package:mandob_moshtarayat_dashboad/module_main/service/home_service.dart';

@injectable
class HomeStateManager {
  final HomeService _homeService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  HomeStateManager(this._homeService);

  void getReport(HomeScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _homeService.getReport().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(HomeLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(HomeLoadedState(screenState, null));
      } else {
        ReportModel data = value as ReportModel;
        _stateSubject.add(HomeLoadedState(screenState, data));
      }
    });
  }
}

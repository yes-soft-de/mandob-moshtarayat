import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_home/model/report_model.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_state/home_state_loaded.dart';
import 'package:mandob_moshtarayat/module_home/service/home_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';

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

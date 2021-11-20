import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/model/captains_report_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/service/reports_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/screen/captains_reports_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/state/captain/captains_report_loaded_state.dart';

@injectable
class CaptainsReportStateManager {
  final ReportsService _reportsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CaptainsReportStateManager(this._reportsService);

  void getReports(CaptainsReportScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _reportsService.getCaptainsReport().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            CaptainsReportLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            CaptainsReportLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        CaptainsReportModel _model = value as CaptainsReportModel;
        _stateSubject.add(CaptainsReportLoadedState(screenState, _model.data));
      }
    });
  }
}

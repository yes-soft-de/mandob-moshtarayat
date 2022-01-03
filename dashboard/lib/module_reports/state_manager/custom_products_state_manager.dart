import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/model/custom_product_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/screen/custom_product_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/state/custom_product/custom_product_loaded.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/model/clients_report_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/service/reports_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/screen/clients_reports_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/ui/state/client/clients_report_loaded_state.dart';

@injectable
class CustomProductStateManager {
  final ReportsService _reportsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CustomProductStateManager(this._reportsService);

  void getReports(CustomProductScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _reportsService.getCustomProduct().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            CustomProductLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            CustomProductLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        CustomProductModel _model = value as CustomProductModel;
        _stateSubject.add(CustomProductLoadedState(screenState, _model.data));
      }
    });
  }
}

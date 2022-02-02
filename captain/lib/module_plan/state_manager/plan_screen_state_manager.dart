import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_captain/module_plan/service/plan_service.dart';
import 'package:mandob_moshtarayat_captain/module_plan/ui/screen/plan_screen.dart';
import 'package:mandob_moshtarayat_captain/module_plan/ui/state/captain_plan_loaded.dart';
import 'package:mandob_moshtarayat_captain/module_plan/ui/state/plan_state.dart';
import 'package:mandob_moshtarayat_captain/module_plan/ui/state/plan_state_loading.dart';

@injectable
class PlanScreenStateManager {
  final stateSubject = PublishSubject<PlanState>();
  final PlanService _planService;

  PlanScreenStateManager(this._planService);
  Stream<PlanState> get stateStream => stateSubject.stream;

  void getAccountBalance(PlanScreenState screenState) {
    stateSubject.add(PlanScreenStateLoading(screenState));
    Future.wait([
      _planService.getAccountBalance(),
      _planService.getAccountBalanceLastMonth(),
    ]).then((value) {
      if (value[0].hasError && value[1].hasError) {
        stateSubject.add(PlanScreenStateError(
            screenState, [value[0].error, value[1].error]));
      } else if (value[1].empty && value[0].empty) {
        stateSubject.add(PlanScreenEmptyState(
          screenState,
        ));
      } else {
        stateSubject.add(CaptainPlanScreenStateLoaded(
            screenState, value[0].data, value[1].data));
      }
    });
  }
}

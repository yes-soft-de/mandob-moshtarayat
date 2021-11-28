import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_captain/module_orders/service/orders/orders.service.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/screens/update/update.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/update/update_state.dart';

@injectable
class UpdateStateManager {
  final OrdersService _ordersService;
  UpdateStateManager(this._ordersService);
  final PublishSubject<UpdateListState> _updateStateSubject =
      PublishSubject<UpdateListState>();
  Stream<UpdateListState> get updateStream => _updateStateSubject.stream;

  void getUpdates(UpdateScreenState screenState) {
    _updateStateSubject.add(UpdateListStateLoading(screenState));
    _ordersService.getUpdates().then((dynamic value) {
      _updateStateSubject.add(UpdateListStateInit(value, screenState));
    });
  }
}

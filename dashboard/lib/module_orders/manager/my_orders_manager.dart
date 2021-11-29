import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/repository/orders_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/my_orders_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_details_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_time_line_response.dart';

@injectable
class MyOrdersManager {
  final MyOrdersRepository _myOrdersRepository;

  MyOrdersManager(this._myOrdersRepository);

  Future<MyOrdersResponse?> getPendingOrders() =>
      _myOrdersRepository.getPendingOrder();
  Future<MyOrdersResponse?> getOngoingOrders() =>
      _myOrdersRepository.getOnGoingOrders();
  Future<MyOrdersResponse?> getOrdersWithoutPending() =>
      _myOrdersRepository.getOrdersWithoutPending();
  Future<MyOrdersResponse?> getFilteredDateOrders(
          String firstDate, String lastDate) =>
      _myOrdersRepository.getFilteredDateOrders(firstDate, lastDate);
  Future<OrderDetailsResponse?> getOrderDetails(int id) =>
      _myOrdersRepository.getOrdersDetails(id);
  Future<OrderTimeLineResponse?> getOrderTimeLine(int id) =>
      _myOrdersRepository.getOrderTimeLine(id);
}

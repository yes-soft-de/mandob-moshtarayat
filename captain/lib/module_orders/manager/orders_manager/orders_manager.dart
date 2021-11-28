import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/module_orders/repository/order_repository/order_repository.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/accept_order_request/accept_order_request.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/billed_calculated.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/order_invoice_request.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/update_order_request/update_order_request.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/company_info/company_info.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/order_details/order_details_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/order_status/order_action_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/order_status/order_status_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders/accept_order_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders/order_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders_logs_response.dart';

@injectable
class OrdersManager {
  final OrderRepository _repository;

  OrdersManager(
    this._repository,
  );

  Future<OrderStatusResponse?> getOrderDetails(int orderId) =>
      _repository.getOrderDetails(orderId);

  Future<OrdersResponse?> getNearbyOrders() => _repository.getNearbyOrders();

  Future<OrdersLogsResponse?> getOrdersLogs() => _repository.getOrdersLogs();

  Future<AcceptOrderResponse?> getCaptainOrders() =>
      _repository.getCaptainOrders();

  Future<CompanyInfoResponse?> getCompanyInfo() => _repository.getCompanyInfo();

  Future<String?> getCaptainStatus() => _repository.getCaptainStatus();

  Future<OrderActionResponse?> updateOrder(
          UpdateOrderRequest updateOrderRequest) =>
      _repository.updateOrderState(updateOrderRequest);

  Future<OrderActionResponse?> updateBill(OrderInvoiceRequest request) =>
      _repository.updateOrderBill(request);
  Future<OrderActionResponse?> billedForCompany(
          BilledCalculatedRequest request) =>
      _repository.billedForCompany(request);

  Future<List?> getUpdates() => _repository.getUpdates();

  Future<Map?> getOrder(int orderId) => _repository.getOrder(orderId);

  Future sendToRecord(var orderId, answer) =>
      _repository.sendToRecord(orderId, answer);
}

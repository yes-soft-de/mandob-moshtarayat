import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/consts/urls.dart';
import 'package:mandob_moshtarayat_captain/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_captain/module_network/http_client/http_client.dart';
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
class OrderRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  OrderRepository(
    this._apiClient,
    this._authService,
  );

  Future<OrdersResponse?> getNearbyOrders() async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.NEARBY_ORDERS_API,
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );

    if (response == null) return null;

    return OrdersResponse.fromJson(response);
  }

  Future<AcceptOrderResponse?> getCaptainOrders() async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.CAPTAIN_ACCEPTED_ORDERS_API,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return AcceptOrderResponse.fromJson(response);
  }

  Future<OrderStatusResponse?> getOrderDetails(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.ORDER_STATUS_API + '$orderId',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response == null) return null;
    return OrderStatusResponse.fromJson(response);
  }

  Future<OrdersLogsResponse?> getOrdersLogs() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_ORDER_LOGS,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return OrdersLogsResponse.fromJson(response);
  }
  /////////////////////////////////////////////////////

  Future<String?> getCaptainStatus() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.CAPTAIN_ACTIVE_STATUS_API,
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) return null;
    return response['Data']['status'] ?? '';
  }

  Future<OrderActionResponse?> updateOrderState(
      UpdateOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      '${Urls.CAPTAIN_ORDER_UPDATE_API}',
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) return null;

    return OrderActionResponse.fromJson(
        response, Urls.CAPTAIN_ORDER_UPDATE_API);
  }

  Future<OrderActionResponse?> updateOrderBill(
      OrderInvoiceRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      '${Urls.ORDER_UPDATE_BILL_API}',
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) return null;

    return OrderActionResponse.fromJson(response, Urls.ORDER_UPDATE_BILL_API);
  }

  Future<OrderActionResponse?> billedForCompany(
      BilledCalculatedRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      '${Urls.BILLED_FOR_COMPANY_API}',
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) return null;

    return OrderActionResponse.fromJson(response, Urls.ORDER_UPDATE_BILL_API);
  }

  Future<CompanyInfoResponse?> getCompanyInfo() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get('${Urls.COMPANYINFO_API}',
        headers: {'Authorization': 'Bearer $token'});

    if (response == null) return null;
    return CompanyInfoResponse.fromJson(response);
  }

  Future<List?> getUpdates() async {
    dynamic response = await _apiClient.get('${Urls.UPDATES_API}');

    if (response == null) return null;
    return response['Data'];
  }

  Future<Map?> getOrder(int orderId) async {
    dynamic response = await _apiClient.get('${Urls.ORDER_BY_ID}$orderId');

    if (response == null) return null;
    return response['Data'];
  }

  Future sendToRecord(var orderId, bool answer) async {
    dynamic response =
        await _apiClient.post('${Urls.SEND_TO_RECORD}/$orderId/$answer', {});
    if (response == null) return null;
    return response;
  }
}

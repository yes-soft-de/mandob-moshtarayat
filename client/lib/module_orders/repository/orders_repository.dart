import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/module_orders/request/create_payment_record_request.dart';
import 'package:mandob_moshtarayat/module_orders/response/client_order_response.dart';
import 'package:mandob_moshtarayat/module_orders/response/my_orders_response.dart';
import 'package:mandob_moshtarayat/module_orders/response/order_details_response/order_details_response.dart';
import 'package:mandob_moshtarayat/module_orders/response/orders_logs_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';

@injectable
class MyOrdersRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  MyOrdersRepository(this._apiClient, this._authService);

  Future<MyOrdersResponse?> getOrders() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_MY_ORDERS,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return MyOrdersResponse.fromJson(response);
  }

  Future<OrdersLogsResponse?> getOrdersLogs() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_ORDER_LOGS,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return OrdersLogsResponse.fromJson(response);
  }

  Future<OrderDetailsResponse?> getOrdersDetails(int id) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(Urls.GET_ORDER_DETAILS + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return OrderDetailsResponse.fromJson(response);
  }

  Future<OrderDetailsResponse?> postClientOrder(
      ClientOrderRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.post(
        Urls.POST_CLIENT_ORDER_API, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return OrderDetailsResponse.fromJson(response);
  }

  Future<ClientOrderResponse?> deleteClientOrder(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.DELETE_CLIENT_ORDER_API + '/$id', {},
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ClientOrderResponse.fromJson(response);
  }

  Future<ClientOrderResponse?> updateClientOrder(
      ClientOrderRequest request) async {
    var token = await _authService.getToken();
    String url;
    if (request.orderType == 2) {
      url = Urls.UPDATE_SPECIAL_CLIENT_ORDER_API;
    } else if (request.orderType == 3) {
      url = Urls.UPDATE_SEND_CLIENT_ORDER_API;
    } else {
      url = Urls.UPDATE_CLIENT_ORDER_API;
    }
    dynamic response = await _apiClient.put(url, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ClientOrderResponse.fromJson(response);
  }

  Future<RateResponse?> createRateCaptain(RateCaptainRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.RATE_CAPTAIN, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return RateResponse.fromJson(response);
  }
    Future<ClientOrderResponse?> updatePaymentRecord(
      CreatePaymentRecordRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(Urls.UPDATE_PAYMENT_RECORD_API, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ClientOrderResponse.fromJson(response);
  }
}

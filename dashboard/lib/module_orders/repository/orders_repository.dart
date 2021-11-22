import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/my_orders_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_details_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/order_time_line_response.dart';

@injectable
class MyOrdersRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  MyOrdersRepository(this._apiClient, this._authService);

  Future<MyOrdersResponse?> getPendingOrder() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_PENDING_ORDER,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return MyOrdersResponse.fromJson(response);
  }

  Future<MyOrdersResponse?> getOrdersWithoutPending() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_PENDING_ORDER,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return MyOrdersResponse.fromJson(response);
  }

  Future<MyOrdersResponse?> getOnGoingOrders() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_ONGOING_ORDERS,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return MyOrdersResponse.fromJson(response);
  }

  Future<OrderDetailsResponse?> getOrdersDetails(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_ORDER_DETAILS + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return OrderDetailsResponse.fromJson(response);
  }

  Future<OrderTimeLineResponse?> getOrderTimeLine(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_ORDER_TIMELINE + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return OrderTimeLineResponse.fromJson(response);
  }

  Future<MyOrdersResponse?> getFilteredDateOrders(
      String firstDate, String lastDate) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_SPECIFIC_DATE_ORDERS + '$firstDate' + '/$lastDate',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return MyOrdersResponse.fromJson(response);
  }
}

import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat/module_our_services/request/private_order_request.dart';
import 'package:mandob_moshtarayat/module_our_services/request/send_it_request.dart';
import 'package:mandob_moshtarayat/module_our_services/response/sendItResponse.dart';

@injectable
class ServicesRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  ServicesRepository(this._apiClient, this._authService);

  Future<SendItResponse?> sendItClintOrder(SendItRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.post(
        Urls.POST_CLIENT_SEND_IT_ORDER_API, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return SendItResponse.fromJson(response);
  }

  Future<SendItResponse?> postPrivateOrder(PrivateOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.POST_CLIENT_PRIVATE_ORDER_API, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return SendItResponse.fromJson(response);
  }
}

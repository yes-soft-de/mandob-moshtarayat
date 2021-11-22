import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/consts/urls.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_network/http_client/http_client.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/request/pay_tabs_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/response/pay_tabs_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';

@injectable
class PortalsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  PortalsRepository(this._apiClient, this._authService);

  Future<PayTabsResponse?> paymentFromCaptain(PayTabsRequest request) async {
    var token = 'SMJNZH99KL-J2JDWRNHRD-LZGHJHJBRZ';
    dynamic response = await _apiClient.post(
        'https://secure-global.paytabs.com/payment/request', request.toJson(),
        headers: {'Authorization': '' + token.toString()});
    if (response == null) return null;
    return PayTabsResponse.fromJson(response);
  }
}

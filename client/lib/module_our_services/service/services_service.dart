import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_our_services/manager/manager.dart';
import 'package:mandob_moshtarayat/module_our_services/model/order_status.dart';
import 'package:mandob_moshtarayat/module_our_services/request/private_order_request.dart';
import 'package:mandob_moshtarayat/module_our_services/request/send_it_request.dart';
import 'package:mandob_moshtarayat/module_our_services/response/sendItResponse.dart';
import 'package:mandob_moshtarayat/utils/helpers/fire_store_helper.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class ServicesService {
  final ServicesManager _servicesManager;
  final FireStoreHelper _fireStoreHelper;
  ServicesService(this._servicesManager, this._fireStoreHelper);
  Future<OrderStateModel> sendItClintOrder(SendItRequest request) async {
    SendItResponse? sendItClientOrderResponse =
        await _servicesManager.sendItClintOrder(request);
    if (sendItClientOrderResponse == null)
      return OrderStateModel.Error(S.current.networkError);
    String statusCode = sendItClientOrderResponse.statusCode ?? '0';
    if (statusCode != '201')
      return OrderStateModel.Error(
          StatusCodeHelper.getStatusCodeMessages(statusCode));
    await _fireStoreHelper.insertWatcher();
    return OrderStateModel.None();
  }

  Future<OrderStateModel> postPrivateOrder(PrivateOrderRequest request) async {
    SendItResponse? privateOrderResponse =
        await _servicesManager.postPrivateOrder(request);
    if (privateOrderResponse == null)
      return OrderStateModel.Error(S.current.networkError);
    String statusCode = privateOrderResponse.statusCode ?? '0';
    if (statusCode != '201')
      return OrderStateModel.Error(
          StatusCodeHelper.getStatusCodeMessages(statusCode));
    await _fireStoreHelper.insertWatcher();
    return OrderStateModel.None();
  }
}

import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/helper/error_messages.dart';
import 'package:mandob_moshtarayat/module_orders/manager/my_orders_manager.dart';
import 'package:mandob_moshtarayat/module_orders/model/deleted_order_status.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_details_model.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_logs.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_model.dart';
import 'package:mandob_moshtarayat/module_orders/request/client_order_request.dart';
import 'package:mandob_moshtarayat/module_orders/request/create_payment_record_request.dart';
import 'package:mandob_moshtarayat/module_orders/response/client_order_response.dart';
import 'package:mandob_moshtarayat/module_orders/response/my_orders_response.dart';
import 'package:mandob_moshtarayat/module_orders/response/order_details_response/order_details_response.dart';
import 'package:mandob_moshtarayat/module_orders/response/orders_logs_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/utils/helpers/fire_store_helper.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class OrdersService {
  final MyOrdersManager _myOrdersManager;
  final FireStoreHelper _fireStoreHelper;

  OrdersService(this._myOrdersManager, this._fireStoreHelper);

  Future<OrderModel> getOrders() async {
    MyOrdersResponse? _ordersResponse = await _myOrdersManager.getOrders();
    if (_ordersResponse == null) {
      return OrderModel.Error(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return OrderModel.Error(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return OrderModel.Empty();
    return OrderModel.Data(_ordersResponse);
  }

  Future<OrderLogsModel> getOrdersLogs() async {
    OrdersLogsResponse? _ordersResponse =
        await _myOrdersManager.getOrdersLogs();
    if (_ordersResponse == null) {
      return OrderLogsModel.Error(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return OrderLogsModel.Error(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return OrderLogsModel.Empty();
    return OrderLogsModel.Data(_ordersResponse);
  }

  Future<OrderDetailsModel> getOrdersDetails(int id) async {
    OrderDetailsResponse? _ordersResponse =
        await _myOrdersManager.getOrderDetails(id);
    if (_ordersResponse == null) {
      return OrderDetailsModel.Error(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return OrderDetailsModel.Error(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return OrderDetailsModel.Empty();
    return OrderDetailsModel.Data(_ordersResponse);
  }

  Future<OrderDetailsModel> postClientOrder(ClientOrderRequest request) async {
    OrderDetailsResponse? clientOrderResponse =
        await _myOrdersManager.postClintOrder(request);
    if (clientOrderResponse == null) {
      return OrderDetailsModel.Error(S.current.networkError);
    }
    if (clientOrderResponse.statusCode != '201') {
      return OrderDetailsModel.Error(StatusCodeHelper.getStatusCodeMessages(
          clientOrderResponse.statusCode));
    }
    await _fireStoreHelper.insertWatcher();
    return OrderDetailsModel.Data(clientOrderResponse);
  }

  Future<MyOrderState> deleteClientOrder(int id) async {
    ClientOrderResponse? clientOrderResponse =
        await _myOrdersManager.deleteClientOrder(id);
    if (clientOrderResponse == null) {
      return MyOrderState.error(S.current.networkError);
    } else {
      if (clientOrderResponse.statusCode == '204') {
        await _fireStoreHelper.insertWatcher();
        return MyOrderState.empty();
      } else if (clientOrderResponse.statusCode == '425') {
        return MyOrderState.error(
            ErrorMessages.getDeleteMessage(clientOrderResponse.data));
      } else {
        return MyOrderState.error(StatusCodeHelper.getStatusCodeMessages(
            int.parse(clientOrderResponse.statusCode ?? '500')));
      }
    }
  }

  Future<MyOrderState> updateClientOrder(ClientOrderRequest request) async {
    ClientOrderResponse? clientOrderResponse =
        await _myOrdersManager.updateClientOrder(request);
    if (clientOrderResponse == null) {
      return MyOrderState.error(S.current.networkError);
    }
    if (clientOrderResponse.statusCode == '204') {
      await _fireStoreHelper.insertWatcher();
      return MyOrderState.empty();
    }
    if (clientOrderResponse.statusCode == '425') {
      return MyOrderState.error(
          ErrorMessages.getDeleteMessage(clientOrderResponse.data));
    }
    return MyOrderState.error(StatusCodeHelper.getStatusCodeMessages(
        clientOrderResponse.statusCode ?? '0'));
  }

  Future<MyOrderState> rateCaptain(RateCaptainRequest request) async {
    RateResponse? rateStoreResponse =
        await _myOrdersManager.rateCaptain(request);
    if (rateStoreResponse == null) {
      return MyOrderState.error(S.current.networkError);
    }
    if (rateStoreResponse.statusCode != '201') {
      return MyOrderState.error(
          StatusCodeHelper.getStatusCodeMessages(rateStoreResponse.statusCode));
    }
    return MyOrderState.empty();
  }
  
  Future<MyOrderState> updatePaymentInfo(CreatePaymentRecordRequest request) async {
    ClientOrderResponse? _clientOrderResponse =
        await _myOrdersManager.updatePaymentRecord(request);
    if (_clientOrderResponse == null) {
      return MyOrderState.error(S.current.networkError);
    }
    if (_clientOrderResponse.statusCode != '200') {
      return MyOrderState.error(
          StatusCodeHelper.getStatusCodeMessages(_clientOrderResponse.statusCode));
    }
    return MyOrderState.empty();
  }

}

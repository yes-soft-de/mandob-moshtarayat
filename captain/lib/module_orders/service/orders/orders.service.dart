import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/update_store_order_status_request.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/order_details_response/order_details_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_deep_links/service/deep_links_service.dart';
import 'package:mandob_moshtarayat_captain/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/accept_order.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/action_state_model.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/order_details_model.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/order_logs.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/order/order_model.dart';
import 'package:mandob_moshtarayat_captain/module_orders/model/update/update_model.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/billed_calculated.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/order_invoice_request.dart';
import 'package:mandob_moshtarayat_captain/module_orders/request/update_order_request/update_order_request.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/company_info/company_info.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/order_status/order_action_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders/accept_order_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders/order_response.dart';
import 'package:mandob_moshtarayat_captain/module_orders/response/orders_logs_response.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/status_code_helper.dart';
import 'package:mandob_moshtarayat_captain/utils/logger/logger.dart';

@injectable
class OrdersService {
  final OrdersManager _ordersManager;

  OrdersService(this._ordersManager);

  Future<String?> getCaptainStatus() async {
    String? response = await _ordersManager.getCaptainStatus();
    return response;
  }

  Future<bool> getConfirmOrderState(var orderId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var confirm = await sharedPreferences
        .getBool('captain is in store owner for order $orderId');
    return confirm == null;
  }

  Future<void> setConfirmOrderState(var orderId, bool answer) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(
        'captain is in store owner for order $orderId', answer);
  }

  Future sendOrderReportState(var orderId, bool answer) async {
    await setConfirmOrderState(orderId, answer);
    var result = await _ordersManager.sendToRecord(orderId, answer);
    return result;
  }

//////////////////////////////////////////////////////////////////////
  Future<OrderDetailsModel> getOrderDetails(int orderId) async {
    OrderDetailsResponse? _ordersResponse =
        await _ordersManager.getOrderDetails(orderId);
    if (_ordersResponse == null)
      return OrderDetailsModel.Error(S.current.networkError);
    if (_ordersResponse.statusCode != '200')
      return OrderDetailsModel.Error(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    if (_ordersResponse.data == null) return OrderDetailsModel.Empty();
    LatLng? myLocation = await DeepLinksService.defaultLocation();
    return OrderDetailsModel.Data(_ordersResponse, myLocation);
  }

  Future<OrderModel> getNearbyOrders() async {
    OrdersResponse? response = await _ordersManager.getNearbyOrders();
    if (response == null) {
      return OrderModel.error(S.current.networkError);
    }
    String code = response.statusCode.toString();
    if (code != '200')
      return OrderModel.error(StatusCodeHelper.getStatusCodeMessages(code));
    if (response.data == null) return OrderModel.empty();
    LatLng? myLocation = await DeepLinksService.defaultLocation();
    return OrderModel.withData(response.data ?? [], myLocation);
  }

  Future<ActionStateModel> updateOrder(UpdateOrderRequest request) async {
    OrderActionResponse? actionResponse =
        await _ordersManager.updateOrder(request);
    if (actionResponse == null)
      return ActionStateModel.error(S.current.networkError);
    if (actionResponse.statusCode != '204')
      return ActionStateModel.error(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    await insertWatcher();
    return ActionStateModel.empty();
  }
   Future<ActionStateModel> updateStoreOrderStatus(UpdateStoreOrderStatusRequest request) async {
    OrderActionResponse? actionResponse =
        await _ordersManager.updateStoreOrderStatus(request);
    if (actionResponse == null)
      return ActionStateModel.error(S.current.networkError);
    if (actionResponse.statusCode != '204')
      return ActionStateModel.error(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    await insertWatcher();
    return ActionStateModel.empty();
  }

  Future<ActionStateModel> updateOrderBill(OrderInvoiceRequest request) async {
    OrderActionResponse? actionResponse =
        await _ordersManager.updateBill(request);
    if (actionResponse == null)
      return ActionStateModel.error(S.current.networkError);
    if (actionResponse.statusCode != '204')
      return ActionStateModel.error(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    await insertWatcher();
    return ActionStateModel.empty();
  }

  Future<ActionStateModel> billedForCompany(
      BilledCalculatedRequest request) async {
    OrderActionResponse? actionResponse =
        await _ordersManager.billedForCompany(request);
    if (actionResponse == null)
      return ActionStateModel.error(S.current.networkError);
    if (actionResponse.statusCode != '204')
      return ActionStateModel.error(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    await insertWatcher();
    return ActionStateModel.empty();
  }

  Stream onInsertChangeWatcher() {
    return FirebaseFirestore.instance
        .collection('twaslna_action')
        .doc('new_action')
        .collection('action_history')
        .snapshots();
  }

  Future<void> insertWatcher() async {
    try {
      await FirebaseFirestore.instance
          .collection('twaslna_action')
          .doc('new_action')
          .collection('action_history')
          .add({'date': DateTime.now().toUtc().toIso8601String()});
    } catch (e) {
      Logger().error('FireStore on action', e.toString(), StackTrace.current);
      return;
    }
  }

  Future<AcceptOrderModel> getCaptainOrders() async {
    AcceptOrderResponse? response = await _ordersManager.getCaptainOrders();
    if (response == null) {
      return AcceptOrderModel.error(S.current.networkError);
    }
    String code = response.statusCode.toString();
    if (response.statusCode != '200')
      return AcceptOrderModel.error(
          StatusCodeHelper.getStatusCodeMessages(code));
    if (response.data == null) return AcceptOrderModel.empty();
    return AcceptOrderModel.withData(response);
  }

  Future<OrderLogsModel> getOrdersLogs() async {
    OrdersLogsResponse? _ordersResponse = await _ordersManager.getOrdersLogs();
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

////////////////////////////////////////////////////////////////////////////
  Future<CompanyInfoResponse?> getCompanyInfo() async {
    CompanyInfoResponse? response = await _ordersManager.getCompanyInfo();
    if (response == null) return null;
    return response;
  }

  Future<List<UpdateModel>?> getUpdates() async {
    List? response = await _ordersManager.getUpdates();
    if (response == null) return null;

    List<UpdateModel> updates = [];

    response.forEach((element) {
      updates.add(UpdateModel.fromJson(element));
    });
    return updates;
  }

  // Future<OrderInfoRespons> getOrder(int orderId) async {
  //   Map? response = await _ordersManager.getOrder(orderId);
  //   if (response == null) return null;
  //   return OrderInfoRespons.fromJson(response);
  // }

}

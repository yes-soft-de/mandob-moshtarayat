import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/manager/my_orders_manager.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_details_model.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_model.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_time_line_model.dart';
import 'package:mandob_moshtarayat/module_orders/response/my_orders_response.dart';
import 'package:mandob_moshtarayat/module_orders/response/order_details_response.dart';
import 'package:mandob_moshtarayat/module_orders/response/order_time_line_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class OrdersService {
  final MyOrdersManager _myOrdersManager;

  OrdersService(this._myOrdersManager);

  Future<DataModel> getPendingOrders() async {
    MyOrdersResponse? _ordersResponse = await _myOrdersManager.getPendingOrders();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return OrderModel.withData(_ordersResponse);
  }
  Future<DataModel> getOngoingOrders() async {
    MyOrdersResponse? _ordersResponse = await _myOrdersManager.getOngoingOrders();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) {
      print('nnn');
      return DataModel.empty();
    }
    return OrderModel.withData(_ordersResponse);
  }

  Future<DataModel> getOrdersWithoutPending() async {
    MyOrdersResponse? _ordersResponse = await _myOrdersManager.getOrdersWithoutPending();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return OrderModel.withData(_ordersResponse);
  }

  Future<DataModel> getFilteredDateOrders(String firstDate,String lastDate) async {
    MyOrdersResponse? _ordersResponse = await _myOrdersManager.getFilteredDateOrders(firstDate, lastDate);
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return OrderModel.withData(_ordersResponse);
  }

  Future<DataModel> getOrdersDetails(int id) async {
    OrderDetailsResponse? _ordersResponse =
        await _myOrdersManager.getOrderDetails(id);
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return OrderDetailsModel.Data(_ordersResponse);
  }
  Future<DataModel> getOrderTimeLine(int id) async {
    OrderTimeLineResponse? _ordersResponse =
    await _myOrdersManager.getOrderTimeLine(id);
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return OrderTimeLineModel.withData(_ordersResponse.data!);
  }
}

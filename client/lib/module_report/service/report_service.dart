import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/model/order_model.dart';
import 'package:mandob_moshtarayat/module_report/manager/report_manager.dart';
import 'package:mandob_moshtarayat/module_report/request/custom_product_request.dart';
import 'package:mandob_moshtarayat/module_report/request/report_request.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';
import 'package:mandob_moshtarayat/utils/response/action_response.dart';

@injectable
class ReportService {
  final ReportManager _manager;
  ReportService(this._manager);

  Future<dynamic> createReport(int id, String reason) {
    return _manager.createReport(ReportRequest(id, reason));
  }
  Future<DataModel> createCustomProduct(CustomProductRequest request) async {
       ActionResponse? _ordersResponse = await _manager.createCustomProduct(request);
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    return DataModel.empty();
  }
}

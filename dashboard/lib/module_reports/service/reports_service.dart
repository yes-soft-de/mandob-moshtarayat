import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/inActiveModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/in_active_captain_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/manager/reports_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/model/captains_report_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/model/clients_report_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/model/product_report_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/model/store_report_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/response/reports_captain_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/response/reports_client_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/response/reports_products_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/response/reports_store_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class ReportsService {
  final ReportsManager _reportManager;

  ReportsService(this._reportManager);

  Future<DataModel> getCaptainsReport() async {
    ReportsCaptainResponse? _reportCaptainResponse =
        await _reportManager.getCaptainsReport();
    if (_reportCaptainResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_reportCaptainResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _reportCaptainResponse.statusCode));
    }
    if (_reportCaptainResponse.data == null) return DataModel.empty();
    return CaptainsReportModel.withData(_reportCaptainResponse.data!);
  }

  Future<DataModel> getClientsReport() async {
    ReportsClientResponse? _reportClientResponse =
        await _reportManager.getClientReport();
    if (_reportClientResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_reportClientResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _reportClientResponse.statusCode));
    }
    if (_reportClientResponse.data == null) return DataModel.empty();
    return ClientsReportModel.withData(_reportClientResponse.data!);
  }

  Future<DataModel> getStoresReport() async {
    ReportsStoreResponse? _storeReportResponse =
        await _reportManager.getStoresReport();
    if (_storeReportResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeReportResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _storeReportResponse.statusCode));
    }
    if (_storeReportResponse.data == null) return DataModel.empty();
    return StoresReportModel.withData(_storeReportResponse.data!);
  }

  Future<DataModel> getProductsReport() async {
    ReportsProductsResponse? _reportProductsResponse =
        await _reportManager.getProductsReport();
    if (_reportProductsResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_reportProductsResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _reportProductsResponse.statusCode));
    }
    if (_reportProductsResponse.data == null) return DataModel.empty();
    return ProductsReportModel.withData(_reportProductsResponse.data!);
  }
}

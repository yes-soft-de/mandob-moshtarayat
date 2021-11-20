import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/manager/logs_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/model/captain_logs_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/response/captain_logs_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class LogsService {
  final LogsManager _logsManager;

  LogsService(this._logsManager);

  Future<DataModel> getCaptainLogs(int captainId) async {
    CaptainLogsResponse? _captainProfileResponse =
        await _logsManager.getCaptainLogs(captainId);
    if (_captainProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _captainProfileResponse.statusCode));
    }
    if (_captainProfileResponse.data == null) return DataModel.empty();
    return CaptainLogsModel.withData(_captainProfileResponse.data!);
  }

  Future<DataModel> getStoreLogs(int storeId) async {
    CaptainLogsResponse? _captainProfileResponse =
        await _logsManager.getStoreLogs(storeId);
    if (_captainProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _captainProfileResponse.statusCode));
    }
    if (_captainProfileResponse.data == null) return DataModel.empty();
    return CaptainLogsModel.withData(_captainProfileResponse.data!);
  }
}

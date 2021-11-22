import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/repository/logs_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/response/captain_logs_response.dart';

@injectable
class LogsManager {
  final LogsRepository _logsRepository;

  LogsManager(this._logsRepository);

  Future<CaptainLogsResponse?> getCaptainLogs(int captainId) =>
      _logsRepository.getCaptainLogs(captainId);
  Future<CaptainLogsResponse?> getStoreLogs(int storeId) =>
      _logsRepository.getStoreLogs(storeId);
}

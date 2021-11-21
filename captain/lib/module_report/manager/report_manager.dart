import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/module_report/repository/report_repository.dart';
import 'package:mandob_moshtarayat_captain/module_report/request/report_request.dart';

@injectable
class ReportManager {
  final ReportRepository _repository;
  ReportManager(this._repository);

  Future<dynamic> createReport(ReportRequest request) =>
      _repository.createReport(request);
}

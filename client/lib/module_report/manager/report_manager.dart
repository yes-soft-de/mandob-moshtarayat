import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_report/repository/report_repository.dart';
import 'package:mandob_moshtarayat/module_report/request/custom_product_request.dart';
import 'package:mandob_moshtarayat/module_report/request/report_request.dart';
import 'package:mandob_moshtarayat/utils/response/action_response.dart';

@injectable
class ReportManager {
  final ReportRepository _repository;
  ReportManager(this._repository);

  Future<dynamic> createReport(ReportRequest request) =>
      _repository.createReport(request);
  Future<ActionResponse?> createCustomProduct(CustomProductRequest request) =>
      _repository.customProductRequest(request);
}

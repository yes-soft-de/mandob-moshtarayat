import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_main/repository/home_repository.dart';
import 'package:mandob_moshtarayat/module_main/response/report_response.dart';
@injectable
class HomeManager {

  final HomeRepository _homeRepository;

  HomeManager(this._homeRepository);

  Future<ReportResponse?> getReport() => _homeRepository.getReport();


}

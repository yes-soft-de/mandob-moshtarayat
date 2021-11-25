import 'package:injectable/injectable.dart';

import 'package:mandob_moshtarayat/module_home/repository/home_repository.dart';
import 'package:mandob_moshtarayat/module_home/response/report_response.dart';

@injectable
class HomeManager {

  final HomeRepository _homeRepository;

  HomeManager(this._homeRepository);

  Future<ReportResponse?> getReport() => _homeRepository.getReport();


}

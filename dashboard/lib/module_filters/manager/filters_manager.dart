import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/in_active_captain_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/repository/filters_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/response/captain_filter_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/response/stores_filter_response.dart';

@injectable
class FiltersManager {
  final FiltersRepository _recordsRepository;

  FiltersManager(this._recordsRepository);

  Future<CaptainFilterResponse?> getCaptainFilter(String key) =>
      _recordsRepository.getCaptainFilter(key);
  Future<StoresFilterResponse?> getStoreFilter(String key) =>
      _recordsRepository.getStoreFilter(key);
}

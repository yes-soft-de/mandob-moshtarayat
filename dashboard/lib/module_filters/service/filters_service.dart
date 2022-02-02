import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/manager/filters_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/model/captain_filter_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/model/store_filter_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/response/captain_filter_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/response/stores_filter_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class FiltersService {
  final FiltersManager _filtersManager;

  FiltersService(this._filtersManager);

  Future<DataModel> getCaptainFilter(String key) async {
    CaptainFilterResponse? _captainFilter =
        await _filtersManager.getCaptainFilter(key);
    if (_captainFilter == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainFilter.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_captainFilter.statusCode));
    }
    if (_captainFilter.data == null) return DataModel.empty();
    return CaptainFilterModel.withData(_captainFilter.data!);
  }

  Future<DataModel> getStoreFilter(String key) async {
    StoresFilterResponse? _captainFilter =
        await _filtersManager.getStoreFilter(key);
    if (_captainFilter == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainFilter.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_captainFilter.statusCode));
    }
    if (_captainFilter.data == null) return DataModel.empty();
    return StoresFilterModel.withData(_captainFilter.data!);
  }
}

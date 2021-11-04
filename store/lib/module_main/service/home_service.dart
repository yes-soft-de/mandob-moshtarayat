import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_main/manager/home_manager.dart';
import 'package:mandob_moshtarayat/module_main/model/report_model.dart';
import 'package:mandob_moshtarayat/module_main/response/report_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class HomeService {
  final HomeManager _homeManager;

  HomeService(this._homeManager);

  Future<DataModel> getReport() async {
    ReportResponse? _storesResponse = await _homeManager.getReport();
    if (_storesResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storesResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storesResponse.statusCode));
    }
    if (_storesResponse.data == null) return DataModel.empty();
    return ReportModel.withData(_storesResponse.data!);
  }


}

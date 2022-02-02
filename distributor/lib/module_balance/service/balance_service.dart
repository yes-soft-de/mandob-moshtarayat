import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_balance/manager/balance_manager.dart';
import 'package:mandob_moshtarayat/module_balance/model/balance_model.dart';
import 'package:mandob_moshtarayat/module_balance/response/balance_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class BalanceService {
  final BalanceManager _manager;

  BalanceService(this._manager);

  Future<DataModel> getFilteredDateBalance(String firstDate,String lastDate) async {
    BalanceResponse? _storeResponse = await _manager.getFilteredDateBalance(firstDate, lastDate);

    if (_storeResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storeResponse.statusCode));
    }
    if (_storeResponse.data == null) return DataModel.empty();
    return BalanceModel.withData(_storeResponse.data!);
  }

}

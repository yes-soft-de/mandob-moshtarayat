import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_balance/manager/balance_manager.dart';
import 'package:mandob_moshtarayat/module_balance/model/balance_model.dart';
import 'package:mandob_moshtarayat/module_balance/responce/balance_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class BalanceService {
  final BalanceManager _storeManager;

  BalanceService(this._storeManager);

  Future<DataModel> getStorePayments() async {
    StoreBalanceResponse? _balanceResponse = await _storeManager.getStorePayments();

    if (_balanceResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_balanceResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_balanceResponse.statusCode));
    }
    if (_balanceResponse.data == null) return DataModel.empty();
    return BalanceModel.withData(_balanceResponse.data!);
  }}
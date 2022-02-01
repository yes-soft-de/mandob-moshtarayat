import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_balance/repository/balance_repository.dart';
import 'package:mandob_moshtarayat/module_balance/response/balance_response.dart';

@injectable
class BalanceManager {

  final BalanceRepository _storesRepository;

  BalanceManager(this._storesRepository);

  Future<BalanceResponse?> getFilteredDateBalance(String firstDate ,String lastDate) => _storesRepository.getFilteredDateBalance(firstDate, lastDate);
}

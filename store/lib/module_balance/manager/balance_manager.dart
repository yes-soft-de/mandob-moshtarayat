import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_balance/repository/balance_repository.dart';
import 'package:mandob_moshtarayat/module_balance/responce/balance_response.dart';

@injectable
class BalanceManager {

  final BalanceRepository _balanceRepository;

  BalanceManager(this._balanceRepository);

  Future<StoreBalanceResponse?> getStorePayments() =>
      _balanceRepository.getStorePayments();

}
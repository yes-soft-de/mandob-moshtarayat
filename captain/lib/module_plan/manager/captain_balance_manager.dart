import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/module_plan/repository/package_balance_repository.dart';
import 'package:mandob_moshtarayat_captain/module_plan/response/account_balance_response.dart';

@injectable
class CaptainBalanceManager {
  final PackageBalanceRepository _packageBalanceRepository;

  CaptainBalanceManager(this._packageBalanceRepository);

  Future<AccountBalanceResponse?> getAccountBalance() =>
      _packageBalanceRepository.getCaptainPackage();

  Future<AccountBalanceResponse?> getAccountBalanceLastMonth() =>
      _packageBalanceRepository.getCaptainPackageLastBalance();
}

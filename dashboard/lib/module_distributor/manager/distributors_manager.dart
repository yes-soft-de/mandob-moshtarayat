import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/repository/distributor_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/request/accept_distro_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distirbutor_reponse.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distro_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distro_unfinished_pyments_response.dart';

@injectable
class DistributorManager {
  final DistributorRepository _distributorRepository;

  DistributorManager(this._distributorRepository);

  Future<DistributorResponse?> getInActiveDistro() =>
      _distributorRepository.getInActiveDistributor();

  Future<DistributorResponse?> getDistros() =>
      _distributorRepository.getDistro();

  Future<ActionResponse?> enableDistro(AcceptDistroRequest request) =>
      _distributorRepository.enableDistro(request);
  Future<DistributorProfileResponse?> getDistorsProfile(int distrId) =>
      _distributorRepository.getDistorsProfile(distrId);
  Future<DistroAccountBalanceResponse?> getAccountBalance(int captainId) =>
      _distributorRepository.getDistroAccountBalance(captainId);
  Future<DistroAccountBalanceResponse?> getAccountBalanceLastMonth(
          int captainId) =>
      _distributorRepository.getDistroAccountBalanceLastBalance(captainId);
//  Future<CaptainUnfinishedPaymentsResponse?> getPayments() =>
//      _distributorRepository.captainPayments();
  Future<DistroUnfinishedPaymentsResponse?> distroRemainingPayments() =>
      _distributorRepository.distroRemainingPayments();
  Future<DistroAccountBalanceResponse?> getAccountBalanceSpecific(
          int captainId, firstDate, lastDate) =>
      _distributorRepository.getCaptainSpecificDate(
          captainId, firstDate, lastDate);
}

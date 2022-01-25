import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/request/accept_captain_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_profile_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_unfinished_pyments_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/repository/distributor_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/request/accept_captain_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distirbutor_reponse.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/captain_remaining_payments_response.dart';

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
//  Future<CaptainAccountBalanceResponse?> getAccountBalance(int captainId) =>
//      _distributorRepository.getCaptainAccountBalance(captainId);
//  Future<CaptainAccountBalanceResponse?> getAccountBalanceLastMonth(
//          int captainId) =>
//      _distributorRepository.getCaptainAccountBalanceLastBalance(captainId);
//  Future<CaptainUnfinishedPaymentsResponse?> getPayments() =>
//      _distributorRepository.captainPayments();
//  Future<CaptainRemainingPaymentsResponse?> getCaptainRemainingPayments() =>
//      _distributorRepository.captainRemainingPayments();
//  Future<CaptainAccountBalanceResponse?> getAccountBalanceSpecific(
//          int captainId, firstDate, lastDate) =>
//      _distributorRepository.getCaptainSpecificDate(
//          captainId, firstDate, lastDate);
}

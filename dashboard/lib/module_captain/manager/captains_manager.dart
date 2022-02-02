import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/repository/captain_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/request/accept_captain_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_profile_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_unfinished_pyments_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/in_active_captain_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/captain_remaining_payments_response.dart';

@injectable
class CaptainManager {
  final CaptainRepository _captainRepository;

  CaptainManager(this._captainRepository);

  Future<InActiveCaptainResponse?> getInActiveCaptain() =>
      _captainRepository.getInActiveCaptain();
  Future<InActiveCaptainResponse?> getCaptains() =>
      _captainRepository.getCaptains();
  Future<ActionResponse?> enableCaptain(AcceptCaptainRequest request) =>
      _captainRepository.enableCaptain(request);
  Future<CaptainProfileResponse?> getCaptainProfile(int captainId) =>
      _captainRepository.getCaptainProfile(captainId);
  Future<CaptainAccountBalanceResponse?> getAccountBalance(int captainId) =>
      _captainRepository.getCaptainAccountBalance(captainId);
  Future<CaptainAccountBalanceResponse?> getAccountBalanceLastMonth(
          int captainId) =>
      _captainRepository.getCaptainAccountBalanceLastBalance(captainId);
  Future<CaptainUnfinishedPaymentsResponse?> getPayments() =>
      _captainRepository.captainPayments();
  Future<CaptainRemainingPaymentsResponse?> getCaptainRemainingPayments() =>
      _captainRepository.captainRemainingPayments();
  Future<CaptainAccountBalanceResponse?> getAccountBalanceSpecific(
          int captainId, firstDate, lastDate) =>
      _captainRepository.getCaptainSpecificDate(captainId, firstDate, lastDate);
}

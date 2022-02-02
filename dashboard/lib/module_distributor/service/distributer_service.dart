import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/manager/distributors_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/distro_payment_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/inActiveModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/model/profile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/request/accept_distro_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distirbutor_reponse.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distro_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/distro_unfinished_pyments_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class DistributorService {
  final DistributorManager _distroManager;

  DistributorService(this._distroManager);

  Future<DataModel> getInActiveDistros() async {
    DistributorResponse? _inActiveCaptainResponse =
        await _distroManager.getInActiveDistro();
    if (_inActiveCaptainResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_inActiveCaptainResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _inActiveCaptainResponse.statusCode));
    }
    if (_inActiveCaptainResponse.data == null) return DataModel.empty();
    return DistributorModel.withData(_inActiveCaptainResponse.data!);
  }

  Future<DataModel> getDistros() async {
    DistributorResponse? _inActiveCaptainResponse =
        await _distroManager.getDistros();
    if (_inActiveCaptainResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_inActiveCaptainResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _inActiveCaptainResponse.statusCode));
    }
    if (_inActiveCaptainResponse.data == null) return DataModel.empty();
    return DistributorModel.withData(_inActiveCaptainResponse.data!);
  }

  Future<DataModel> getDistorProfile(int captainId) async {
    DistributorProfileResponse? _captainProfileResponse =
        await _distroManager.getDistorsProfile(captainId);
    if (_captainProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _captainProfileResponse.statusCode));
    }
    if (_captainProfileResponse.data == null) return DataModel.empty();
    return ProfileModel.withData(_captainProfileResponse.data!);
  }

  Future<DataModel> getDistroBalance(int captainId) async {
    DistroAccountBalanceResponse? _captainProfileResponse =
        await _distroManager.getAccountBalance(captainId);
    if (_captainProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _captainProfileResponse.statusCode));
    }
    if (_captainProfileResponse.data == null) return DataModel.empty();
    return BalanceModel.withData(_captainProfileResponse.data!);
  }
//
  Future<DataModel> getDistroBalanceLastMonth(int captainId) async {
    DistroAccountBalanceResponse? _captainProfileResponse =
        await _distroManager.getAccountBalanceLastMonth(captainId);
    if (_captainProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _captainProfileResponse.statusCode));
    }
    if (_captainProfileResponse.data == null) return DataModel.empty();
    return BalanceModel.withData(_captainProfileResponse.data!);
  }
//
  Future<DataModel> getPayments() async {
    DistroUnfinishedPaymentsResponse? _paymentResponse =
        await _distroManager.distroRemainingPayments();
    if (_paymentResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_paymentResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_paymentResponse.statusCode));
    }
    if (_paymentResponse.data == null) return DataModel.empty();
    return DistroPaymentModel.withData(_paymentResponse.data!);
  }
//
//  Future<DataModel> getRemainingPayments() async {
//    CaptainRemainingPaymentsResponse? _paymentResponse =
//        await _distroManager.getCaptainRemainingPayments();
//    if (_paymentResponse == null) {
//      return DataModel.withError(S.current.networkError);
//    }
//    if (_paymentResponse.statusCode != '200') {
//      return DataModel.withError(
//          StatusCodeHelper.getStatusCodeMessages(_paymentResponse.statusCode));
//    }
//    if (_paymentResponse.data == null) return DataModel.empty();
//    return OrderAccountModel.withData(_paymentResponse.data!);
//  }
//
  Future<DataModel> enableDistro(AcceptDistroRequest request) async {
    ActionResponse? actionResponse =
        await _distroManager.enableDistro(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
//
  Future<DataModel> getDistroSpecificDate(
      int captainId, String firstDate, String lastDate) async {
    DistroAccountBalanceResponse? _captainProfileResponse =
        await _distroManager.getAccountBalanceSpecific(
            captainId, firstDate, lastDate);
    if (_captainProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _captainProfileResponse.statusCode));
    }
    if (_captainProfileResponse.data == null) return DataModel.empty();
    return BalanceModel.withData(_captainProfileResponse.data!);
  }
}

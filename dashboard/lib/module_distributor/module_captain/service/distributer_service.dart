import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/manager/captains_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/balance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/captain_model_payment_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/inActiveModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/model/porfile_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/request/accept_captain_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_account_balance_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_profile_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/captain_unfinished_pyments_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/in_active_captain_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/module_captain/manager/distributors_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/module_captain/model/inActiveModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/module_captain/response/distirbutor_reponse/distirbutor_reponse.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/model/order_account_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/response/captain_remaining_payments_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class DistributerService {
  final DistributorManager _distroManager;

  DistributerService(this._distroManager);

  Future<DataModel> getInActiveDistros() async {
    DistirbutorReponse? _inActiveCaptainResponse =
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
    DistirbutorReponse? _inActiveCaptainResponse =
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

  Future<DataModel> getCaptainProfile(int captainId) async {
    CaptainProfileResponse? _captainProfileResponse =
        await _distroManager.getCaptainProfile(captainId);
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

  Future<DataModel> getCaptainBalance(int captainId) async {
    CaptainAccountBalanceResponse? _captainProfileResponse =
        await _distroManager.getAccountBalance(captainId);
    if (_captainProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _captainProfileResponse.statusCode));
    }
    if (_captainProfileResponse.data == null) return DataModel.empty();
    return BalanceModel.withData(_captainProfileResponse.data!.first);
  }

  Future<DataModel> getCaptainBalanceLastMonth(int captainId) async {
    CaptainAccountBalanceResponse? _captainProfileResponse =
        await _distroManager.getAccountBalanceLastMonth(captainId);
    if (_captainProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _captainProfileResponse.statusCode));
    }
    if (_captainProfileResponse.data == null) return DataModel.empty();
    return BalanceModel.withData(_captainProfileResponse.data!.first);
  }

  Future<DataModel> getPayments() async {
    CaptainUnfinishedPaymentsResponse? _paymentResponse =
        await _distroManager.getPayments();
    if (_paymentResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_paymentResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_paymentResponse.statusCode));
    }
    if (_paymentResponse.data == null) return DataModel.empty();
    return CaptainPaymentModel.withData(_paymentResponse.data!);
  }

  Future<DataModel> getRemainingPayments() async {
    CaptainRemainingPaymentsResponse? _paymentResponse =
        await _distroManager.getCaptainRemainingPayments();
    if (_paymentResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_paymentResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_paymentResponse.statusCode));
    }
    if (_paymentResponse.data == null) return DataModel.empty();
    return OrderAccountModel.withData(_paymentResponse.data!);
  }

  Future<DataModel> enableCaptain(AcceptCaptainRequest request) async {
    ActionResponse? actionResponse =
        await _distroManager.enableCaptain(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getCaptainSpecificDate(
      int captainId, String firstDate, String lastDate) async {
    CaptainAccountBalanceResponse? _captainProfileResponse =
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
    return BalanceModel.withData(_captainProfileResponse.data!.first);
  }
}

import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/manager/payments_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/model/payments_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/distro_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/response/payment_list_response/payment_list_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class PaymentsService {
  final PaymentsManager _paymentsManager;

  PaymentsService(this._paymentsManager);

  Future<DataModel> paymentFromCaptain(CaptainPaymentsRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.paymentFromCaptain(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> paymentToCaptain(CaptainPaymentsRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.paymentToCaptain(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deletePaymentToCaptain(String id) async {
    ActionResponse? actionResponse =
        await _paymentsManager.deletePaymentToCaptain(id);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deletePaymentFromCaptain(String id) async {
    ActionResponse? actionResponse =
        await _paymentsManager.deletePaymentFromCaptain(id);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getPayments() async {
    PaymentListResponse? actionResponse =
        await _paymentsManager.getPaymentList();
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return PaymentsModel.withData(actionResponse.data ?? []);
  }

  Future<DataModel> paymentToDistro(DistroPaymentsRequest request) async {
    ActionResponse? actionResponse =
    await _paymentsManager.paymentToDistro(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deletePaymentToDistro(String id) async {
    ActionResponse? actionResponse =
    await _paymentsManager.deletePaymentToDistro(id);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}

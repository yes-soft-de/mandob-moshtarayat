import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/manager/stores_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/request/store_payment_request.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class StorePaymentsService {
  final StoreManager _storeManager;
  StorePaymentsService(this._storeManager);

 Future<DataModel> paymentToStore(StorePaymentRequest request) async {
    ActionResponse? actionResponse =
        await _storeManager.createStorePayment(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}

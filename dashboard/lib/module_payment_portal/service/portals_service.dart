import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/manager/captains_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/request/accept_captain_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/manager/portals_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/request/pay_tabs_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_payment_portal/response/pay_tabs_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/manager/payments_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/request/captain_payments_request.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class PortalsService {
  final PortalsManager _paymentsManager;

  PortalsService(this._paymentsManager);

  Future<DataModel> paymentFromCaptain(PayTabsRequest request) async {
    PayTabsResponse? actionResponse =
        await _paymentsManager.paymentFromCaptain(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }

    return DataModel.empty();
  }
}

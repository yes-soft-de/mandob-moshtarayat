import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_orders/model/deleted_order_status.dart';
import 'package:mandob_moshtarayat/module_products/manager/products_manager.dart';
import 'package:mandob_moshtarayat/module_products/model/products_details_model.dart';
import 'package:mandob_moshtarayat/module_products/response/products_details_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_response.dart';
import 'package:mandob_moshtarayat/module_stores/request/rate_store_request.dart';
import 'package:mandob_moshtarayat/utils/helpers/status_code_helper.dart';

@injectable
class ProductsService {
  final ProductsManager _productsManager;

  ProductsService(this._productsManager);

  Future<DataModel> getProductsDetails(int id) async {
    ProductsDetailsResponse? storeProfileResponse =
        await _productsManager.getProductsDetails(id);
    if (storeProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (storeProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          storeProfileResponse.statusCode));
    }
    if (storeProfileResponse.data == null) return DataModel.empty();
    return ProductsDetailsModel.withData(storeProfileResponse.data!);
  }

  Future<MyOrderState> rateStore(RateStoreRequest request) async {
    RateResponse? rateStoreResponse =
        await _productsManager.rateProducts(request);
    if (rateStoreResponse == null) {
      return MyOrderState.error(S.current.networkError);
    }
    if (rateStoreResponse.statusCode != '201') {
      return MyOrderState.error(
          StatusCodeHelper.getStatusCodeMessages(rateStoreResponse.statusCode));
    }
    return MyOrderState.empty();
  }
}

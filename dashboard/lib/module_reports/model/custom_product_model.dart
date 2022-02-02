import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/response/custom_product_response/datum.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/response/custom_product_response/product_image.dart';

class CustomProductModel extends DataModel {
  String requestID = '-1';
  late String productName;
  ProductImage? productImage;
  String? detail;

  CustomProductModel(
      {required this.requestID,
      required this.productName,
      required this.detail,
      required this.productImage});

  List<CustomProductModel> _models = [];

  CustomProductModel.withData(List<Datum> data) : super.withData() {
    _models = [];
    data.forEach((element) {
      _models.add(CustomProductModel(
        requestID: element.id.toString(),
        detail: element.detail ?? '',
        productImage: element.productImage,
        productName: element.productName ?? S.current.unknown,
      ));
    });
  }

  List<CustomProductModel> get data => _models;
}

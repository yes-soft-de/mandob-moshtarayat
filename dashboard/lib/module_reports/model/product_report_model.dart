import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/response/reports_products_response.dart';

class ProductsReportModel extends DataModel {
  int productID = -1;
  int countOrdersInMonth = 0;
  String productName = '';
  String productImage = '';

  ProductsReportModel(
      {required this.productID,
      required this.productName,
      required this.productImage,
      required this.countOrdersInMonth});

  List<ProductsReportModel> _models = [];

  ProductsReportModel.withData(List<Data> data) : super.withData() {
    _models = [];
    data.forEach((element) {
      _models.add(ProductsReportModel(
          productID: element.productID ?? -1,
          countOrdersInMonth: element.countOrdersInMonth ?? 0,
          productImage: element.productImage ?? '',
          productName: element.productName ?? ''));
    });
  }

  List<ProductsReportModel> get data => _models;
}

import 'dart:math';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/response/financial_compensations_response.dart';

class CompanyFinanceModel extends DataModel {
  int id = -1;
  num kilometers = 0;
  num maxKilometerBonus = 0;
  num minKilometerBonus = 0;

  CompanyFinanceModel({
    required this.id,
    required this.kilometers,
    required this.maxKilometerBonus,
    required this.minKilometerBonus,
  });
  CompanyFinanceModel? _model;
  CompanyFinanceModel.withData(Data data) : super.withData() {
    _model = CompanyFinanceModel(
        id: data.id ?? -1,
        kilometers: data.kilometers ?? 0,
        maxKilometerBonus: data.maxKilometerBonus ?? 0,
        minKilometerBonus: data.minKilometerBonus ?? 0);
  }

  CompanyFinanceModel get data {
    if (_model != null) {
      return _model!;
    } else {
      throw Exception('There is no data');
    }
  }
}

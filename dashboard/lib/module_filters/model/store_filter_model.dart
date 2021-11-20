import 'dart:math';

import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/response/stores_filter_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/images/images.dart';

class StoresFilterModel extends DataModel {
  int id = -1;
  String storeOwnerName = '';
  String categoryId = '';
  String phone = '';
  num deliveryCost = 0;
  String image = '';
  bool privateOrders = false;
  bool hasProducts = false;
  DateTime? closingTime;
  DateTime? openingTime;

  List<StoresFilterModel> _models = [];

  StoresFilterModel({
    required this.id,
    required this.storeOwnerName,
    required this.categoryId,
    required this.phone,
    required this.image,
    required this.privateOrders,
    required this.hasProducts,
  });

  StoresFilterModel.withData(List<Data> data) : super.withData() {
    _models = [];
    for (var element in data) {
      if (element.image != null &&
          (element.image?.contains('original-image') ?? false) == false) {
        int f = Random().nextInt(1600);
        int s = Random().nextInt(900);
        element.image = 'https://source.unsplash.com/${f}x${s}/?store';
      }
      _models.add(StoresFilterModel(
        id: element.id ?? -1,
        categoryId: element.storeCategoryId?.toString() ?? '-1',
        storeOwnerName: element.storeOwnerName ?? S.current.store,
        hasProducts: element.hasProducts ?? false,
        privateOrders: element.privateOrders ?? false,
        image: element.image ?? ImageAsset.PLACEHOLDER,
        phone: element.phone ?? '',
      ));
    }
  }

  List<StoresFilterModel> get data => _models;
}

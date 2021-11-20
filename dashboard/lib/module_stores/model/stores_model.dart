import 'dart:math';

import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/response/stores_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/date_converter.dart';
import 'package:mandob_moshtarayat_dashboad/utils/images/images.dart';

class StoresModel extends DataModel {
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
  String status = '';
  List<StoresModel> _models = [];

  StoresModel(
      {required this.id,
      required this.storeOwnerName,
      required this.phone,
      required this.deliveryCost,
      required this.image,
      required this.privateOrders,
      required this.hasProducts,
      required this.categoryId,
      this.openingTime,
      this.closingTime,
      required this.status});

  StoresModel.withData(List<Data> data) : super.withData() {
    _models = [];
    for (var element in data) {
      _models.add(StoresModel(
          id: element.id ?? -1,
          categoryId: element.categoryId?.toString() ?? '-1',
          storeOwnerName: element.storeOwnerName ?? S.current.store,
          deliveryCost: element.deliveryCost ?? 0,
          hasProducts: element.hasProducts ?? false,
          privateOrders: element.privateOrders ?? false,
          image: element.image ?? ImageAsset.PLACEHOLDER,
          phone: element.phone ?? '',
          openingTime: DateHelper.convert(element.openingTime?.timestamp),
          closingTime: DateHelper.convert(element.closingTime?.timestamp),
          status: element.status ?? ''));
    }
  }

  List<StoresModel> get data => _models;
}

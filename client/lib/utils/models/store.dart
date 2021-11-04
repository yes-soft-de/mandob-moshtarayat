import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/response/best_store.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_category_list.dart';

class StoreModel {
  late int id;
  late String storeOwnerName;
  late String image;
  dynamic phone;
  dynamic location;
  late num deliveryCost;
  late bool hasProducts;
  late bool privateOrders;
  String? error;
  bool empty = false;
  num? rating;
  List<StoreModel> models = [];
  StoreModel(
      {required this.deliveryCost,
      required this.id,
      required this.storeOwnerName,
      required this.image,
      this.phone,
      this.location,
      this.rating,
      required this.hasProducts,
      required this.privateOrders});
  StoreModel.none();
  StoreModel.withData(data);

  StoreModel.Empty() {
    this.empty = true;
  }

  StoreModel.Error(this.error);

  StoreModel.Data(StoreCategoryList bestStores) {
    var data = bestStores.data;
    data!.forEach((element) {
      models.add(StoreModel(
          id: element.id ?? -1,
          storeOwnerName: element.storeOwnerName ?? S.current.store,
          deliveryCost: element.deliveryCost ?? 0,
          hasProducts: element.hasProducts ?? false,
          privateOrders: element.privateOrders ?? false,
          image: element.image ?? '',
          rating: element.rating?.rate ?? 0));
    });
  }

  bool get hasError => error != null;

  bool get isEmpty => empty;

  List<StoreModel> get data {
    return models;
  }
}

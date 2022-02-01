import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_profile_response.dart';

class StoreProfile extends StoreModel {
  @override
  late int id;
  @override
  late String storeOwnerName;
  @override
  late String image;
  @override
  dynamic phone;
  @override
  late num deliveryCost;
  @override
  late bool hasProducts;
  @override
  late bool privateOrders;
  @override
  String? error;
  @override
  bool empty = false;
  @override
  num? rating;
  late StoreProfile _storeProfile;

  StoreProfile(
      {required this.id,
      required this.storeOwnerName,
      required this.image,
      required this.phone,
      required this.deliveryCost,
      required this.hasProducts,
      required this.privateOrders,
      required this.rating})
      : super.none();

  StoreProfile.withData(Data element) : super.none() {
    _storeProfile = StoreProfile(
        id: element.id ?? -1,
        storeOwnerName: element.storeOwnerName ?? S.current.store,
        deliveryCost: element.deliveryCost ?? 0,
        hasProducts: element.hasProducts ?? false,
        privateOrders: element.privateOrders ?? false,
        image: element.image?.image ?? '',
        rating: num.parse(element.rating ?? '0'),
        phone: element.phone);
  }

  StoreProfile get profile {
    return _storeProfile;
  }
}

import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/date_converter.dart';
import 'package:mandob_moshtarayat_dashboad/utils/images/images.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/response/store_profile_response.dart';

class StoreProfileModel extends DataModel {
  int id = -1;
  String storeOwnerName = '';
  String categoryId = '';
  String phone = '';
  String stcPay = '';
  String bankName = '';
  String bankNumber = '';
  num deliveryCost = 0;
  String image = '';
  bool privateOrders = false;
  bool hasProducts = false;
  String? closingTime;
  String? openingTime;

  StoreProfileModel? _models;

  StoreProfileModel(
      {required this.id,
      required this.storeOwnerName,
      required this.phone,
      required this.deliveryCost,
      required this.image,
      required this.privateOrders,
      required this.hasProducts,
      required this.categoryId,
      this.closingTime,
      this.openingTime,
        required this.stcPay ,required this.bankName ,required this.bankNumber

      });

  StoreProfileModel.withData(Data data) : super.withData() {
    _models = StoreProfileModel(
      id: data.id ?? -1,
      categoryId: '-1',
      storeOwnerName: data.storeOwnerName ?? S.current.store,
      deliveryCost: data.deliveryCost ?? 0,
      hasProducts: data.hasProducts ?? false,
      privateOrders: data.privateOrders ?? false,
      image: data.image?.imageURL ?? ImageAsset.PLACEHOLDER,
      phone: data.phone ?? '',
      openingTime: DateFormat.jm()
          .format(DateHelper.convert(data.openingTime?.timestamp)),
      closingTime: DateFormat.jm()
          .format(DateHelper.convert(data.closingTime?.timestamp)),
        stcPay: data.stcPay??'',
        bankName: data.bankName??'',
        bankNumber: data.bankAccountNumber??''
    );
  }

  StoreProfileModel get data {
    if (_models != null) {
      return _models!;
    } else {
      throw Exception('There is no data');
    }
  }
}

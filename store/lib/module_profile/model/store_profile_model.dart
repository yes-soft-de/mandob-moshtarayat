import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_profile/response/store_profile_response.dart';
import 'package:mandob_moshtarayat/utils/helpers/date_converter.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';


class StoreProfileModel extends DataModel {
  int id = -1;
  String storeOwnerName = '';
  int storeCategoryId = -1;
  String phone = '';
  String stcPay = '';
  String bankName = '';
  String bankNumber = '';
  String storeCategoryName = '';
  num deliveryCost = 0;
  ImageUrl image = ImageUrl(image: null);
  bool privateOrders = false;
  bool hasProducts = false;
  DateTime? closingTime;
  DateTime? openingTime;
  List<BranchesModel>? branches;

  StoreProfileModel? _models;

  StoreProfileModel(
      {required this.id,
      required this.storeOwnerName,
      required this.phone,
      required this.deliveryCost,
        required this.storeCategoryName,
      required this.image,
      required this.privateOrders,
      required this.hasProducts,
      required this.storeCategoryId,
      this.closingTime,
      this.openingTime,
        this.branches,
       required this.stcPay ,required this.bankName ,required this.bankNumber
      });

  StoreProfileModel.withData(Data data) : super.withData() {
    List<BranchesModel> branches =[];
    data.branches!.forEach((v) {
      branches.add(BranchesModel(isActive: v.isActive??false,location: Location(lat: v.location?.lat,lon: v.location?.lon)));
    });
    _models = StoreProfileModel(
      storeCategoryName: data.storeCategoryName??'',
        id: data.id ?? -1,
        storeCategoryId: data.storeCategoryId ??-1,
        storeOwnerName: data.storeOwnerName ?? S.current.store,
        deliveryCost: data.deliveryCost ?? 0,
        hasProducts: data.hasProducts ?? false,
        privateOrders: data.privateOrders ?? false,
        image:data.imageURL ??ImageUrl(image:ImageAsset.PLACEHOLDER ),
        phone: data.phone ?? '',
       openingTime:DateHelper.convert(data.openingTime?.timestamp),
       closingTime:DateHelper.convert(data.closingTime?.timestamp),
      branches: branches,
      stcPay: data.stcPay??'',
      bankName: data.bankName??'',
      bankNumber: data.bankAccountNumber??''
    );
  }

  StoreProfileModel get data {
    if (_models != null) {
      return _models!;
    }
    else {
      throw Exception('There is no data');
    }
  }
}

class BranchesModel extends DataModel{
  Location location=Location(lat: 0,lon: 0);
  bool isActive=false;

  BranchesModel? _models;

  BranchesModel({required this.location, required this.isActive});

  BranchesModel.withData(Branches data) : super.withData() {
    _models = BranchesModel(
      location: data.location??Location(lat: 0,lon: 0),
      isActive: data.isActive??false
    );
  }

  BranchesModel get data {
    if (_models != null) {
      return _models!;
    }
    else {
      throw Exception('There is no data');
    }
  }
// bool checkLatLonValue(Location location){
//    if(-90 <= location.lon && location.lon <= 90  && -90 <= location.lat && location.lat <= 90  ){
//      return true;
//    }
//    return false;
//  }
}
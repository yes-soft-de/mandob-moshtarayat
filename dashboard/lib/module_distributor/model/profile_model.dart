 import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/datum.dart';

class ProfileModel extends DataModel {
  String? image;
  String? name;
  String? phone;
  String? stcPay;
  String? bankNumber;
  String? bankName;

  num? age;

  String? status;

  String? createDate;
  ProfileModel(
      {this.image,
        this.name,
        this.phone,
        this.stcPay,
        this.bankNumber,
        this.bankName,

        this.age,

        this.status,

        this.createDate});

  ProfileModel? _models;

  ProfileModel.withData(Datum data) : super.withData() {
    _models = ProfileModel(
        image: data.image?.imageUrl??'',
        name: data.mandobName,
        phone: data.phone,
        stcPay: data.stcPay,
        bankName: data.bankName,
        bankNumber: data.bankAccountNumber,

        age: data.age,

        status: data.status);
  }

  ProfileModel get data => _models ?? ProfileModel();
}
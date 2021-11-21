import 'package:mandob_moshtarayat_captain/module_profile/response/profile_response.dart';

class ProfileModel {
  String? image;
  String? name;
  String? phone;
  String? stcPay;
  String? bankNumber;
  String? bankName;
  String? drivingLicence;
  String? car;
  String? identity;
  String? mechanicLicense;
  int? age;
  String? isOnline;
  ProfileModel(
      {this.image,
      this.name,
      this.phone,
      this.stcPay,
      this.bankNumber,
      this.bankName,
      this.drivingLicence,
      this.car,
      this.identity,
      this.mechanicLicense,
      this.age,
      this.isOnline});

  String? _error;
  bool _empty = false;
  ProfileModel? _models;
  ProfileModel.error(this._error);
  ProfileModel.empty() {
    _empty = true;
  }
  ProfileModel.withData(ProfileResponseModel data) {
    _models = ProfileModel(
        image: data.image,
        name: data.captainName,
        phone: data.phone,
        stcPay: data.stcPay,
        bankName: data.bankName,
        bankNumber: data.bankAccountNumber,
        car: data.car,
        age: data.age,
        mechanicLicense: data.mechanicLicense,
        drivingLicence: data.drivingLicence,
        identity: data.identity,
        isOnline: data.isOnline);
  }
  bool get hasError => _error != null;
  bool get empty => _empty;
  ProfileModel get data => _models ?? ProfileModel.empty();
  String get error => _error ?? '';
}

class CreateCaptainProfileRequest {
  String? image;
  String? drivingLicence;
  String? mechanicLicence;
  String? identity;
  String? car;
  int? age;
  String? name;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  bool? isOnline;
  String? phone;

  CreateCaptainProfileRequest({this.image,
    this.drivingLicence,
    this.age,
    this.car,
    this.name,
    this.identity,
    this.mechanicLicence});

  Uri? mechanic;
  Uri? captainImage;
  Uri? driving;
  Uri? idImage;

  CreateCaptainProfileRequest.withUriImages({this.name,
    this.age,
    this.car,
    this.mechanic,
    this.captainImage,
    this.driving,
    this.idImage,
    this.bankName,
    this.bankAccountNumber,
    this.phone,
    this.stcPay,
  });

  Map<String, dynamic> toJSON() {
    return {
      'image': image,
      'drivingLicence': drivingLicence,
      'age': age,
      'mechanicLicense': mechanicLicence,
      'identity': identity,
      'car': car,
      'isOnline': 'active',
      'phone':phone,
      'stcPay':stcPay,
      'bankAccountNumber':bankAccountNumber,
      'bankName':bankName
    };
  }
}

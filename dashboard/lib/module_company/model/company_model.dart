import 'dart:math';

import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/response/company_profile_response.dart';

class CompanyProfileModel extends DataModel {
  int id = -1;
  String phone = '';
  String phone2 = '';
  String whatsapp = '';
  String fax = '';
  String bank = '';
  String stc = '';
  String email = '';
  String roomID = '';
  CompanyProfileModel? _model;

  CompanyProfileModel(
      {required this.id,
      required this.phone,
      required this.phone2,
      required this.whatsapp,
      required this.fax,
      required this.bank,
      required this.stc,
      required this.email,
      required this.roomID});

  CompanyProfileModel.withData(List<Data> data) : super.withData() {
    _model = CompanyProfileModel(
        id: data[0].id ?? -1,
        phone: data[0].phone ?? '',
        phone2: data[0].phone2 ?? '',
        whatsapp: data[0].whatspp ?? '',
        fax: data[0].fax ?? '',
        bank: data[0].bank ?? '',
        stc: data[0].stc ?? '',
        email: data[0].email ?? '',
        roomID: data[0].roomID ?? '');
  }

  CompanyProfileModel get data {
    if (_model != null) {
      return _model!;
    } else {
      throw Exception('There is no data');
    }
  }
}

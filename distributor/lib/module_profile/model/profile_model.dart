
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/module_profile/response/profile_response.dart';



class  ProfileModel extends DataModel {
  int id = -1;
  String mandobName = '';
  String phone = '';
  String stcPay = '';
  String bankName = '';
  String bankNumber = '';
  String roomID='';
  String status='';
  num age = 0;
  String? image;


  ProfileModel? _models;

  ProfileModel(
      {required this.id,
      required this.mandobName,
      required this.phone,
        required this.roomID,
       required this.status,
      required this.stcPay ,required this.bankName ,required this.bankNumber,required this.age,required this.image,
      });

  ProfileModel.withData(Data data) : super.withData() {
    _models = ProfileModel(
      id: data.id??-1,
      stcPay: data.stcPay??'',
      bankName: data.bankName??'',
      bankNumber: data.bankAccountNumber??'',
      age: data.age??0,
      mandobName: data.mandobName??'',
      phone: data.phone??'',
      roomID: data.roomID??'',
      image: data.imageURL!.image??'',
      status: data.status??''

    );
  }
  ProfileModel.empty() {
//    _empty = true;
  }
  ProfileModel get data {
    if (_models != null) {
      return _models!;
    }
    else {
      throw Exception('There is no data');
    }
  }
}

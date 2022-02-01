
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/module_stores/response/store_response.dart';

class  StoreModel extends DataModel {
  int id = -1;
  String storeName = '';
  String phone = '';
  String status='';
  String? image;
 List<StoreModel> _models =[];

  StoreModel(
      {required this.id,
      required this.storeName,
      required this.phone,

       required this.status,
      required this.image,
      });

  StoreModel.withData(List <Data> data) : super.withData() {
    _models = [];
    for (var element in data) {
      _models.add(StoreModel(
          id: element.id??-1,
          storeName: element.storeOwnerName??'',
          phone: element.phone??'',
          image: element.imageURL!.image??'',
          status: element.status??''
      ));
    }
  }

  StoreModel.empty() {
//    _empty = true;
  }
  List<StoreModel> get data => _models;
}

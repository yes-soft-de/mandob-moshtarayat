import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/response/distirbutor_reponse/datum.dart';

class DistributorModel extends DataModel {
  late String distroID;
  late String distroName ;
  late String image;
  String? age = '';

  List<DistributorModel> _model = [];

  DistributorModel(
      {
      required this.distroID,
      required this.image,
      required this.distroName,
      required this.age
      });

  DistributorModel.withData(List<Datum> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(DistributorModel(
          distroID: element.id?.toString() ?? '-1',
          image: element.image?.image ?? '',
          distroName: element.mandobName ?? '',
          age: element.age?.toString() ?? ''));
    }
  }
  List<DistributorModel> get data => _model;
}

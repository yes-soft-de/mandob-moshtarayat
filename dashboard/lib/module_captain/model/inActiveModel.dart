import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/response/in_active_captain_response.dart';

class InActiveModel extends DataModel {
  String captainID = '';
  String captainName = '';
  String image = '';
  String? age = '';

  List<InActiveModel> _model = [];

  InActiveModel(
      {required this.captainID,
      required this.image,
      required this.captainName,
      required this.age});

  InActiveModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(InActiveModel(
          captainID: element.captainID ?? '-1',
          image: element.image ?? '',
          captainName: element.captainName ?? '',
          age: element.age?.toString() ?? ''));
    }
  }
  List<InActiveModel> get data => _model;
}

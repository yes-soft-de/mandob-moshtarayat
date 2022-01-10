import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_category_response.dart';

class CategoryModel extends DataModel {
  String categoryName = '';
  String categoryImage = '';
  String imageUrl = '';
  List<Translate>? translate=[];

  int id = -1;

  CategoryModel? _model;

  CategoryModel({required this.categoryName, required this.id , required this.categoryImage ,required this.translate ,required this.imageUrl});

  CategoryModel.withData(Data data) : super.withData() {
    print('InDataModel');
    print(data.categoryName);
    _model = CategoryModel(
        id: data.id??-1,
        translate: data.translates,
        categoryName: data.categoryName??'',
      categoryImage: data.categoryImage?.image??'',imageUrl: data.categoryImage?.imageURL??'');
  }
  CategoryModel get data {
    if (_model != null) {
      return _model!;
    } else {
      throw Exception('There is no data');
    }
  }
}
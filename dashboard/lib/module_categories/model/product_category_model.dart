import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/product_category_response.dart';

class ProductCategoryModel extends DataModel {
  String categoryName = '';
  String categoryImage = '';
  String imageUrl = '';
  List<Translate>? translate=[];

  int id = -1;

  ProductCategoryModel? _model;

  ProductCategoryModel({required this.categoryName, required this.id , required this.categoryImage ,required this.translate ,required this.imageUrl});

  ProductCategoryModel.withData(Data data) : super.withData() {
    print('InDataModel');
    print(data.categoryName);
    _model = ProductCategoryModel(
        id: data.id??-1,
        translate: data.translates,
        categoryName: data.categoryName??'',
      categoryImage: data.categoryImage?.image??'',imageUrl: data.categoryImage?.imageURL??'');
  }
  ProductCategoryModel get data {
    if (_model != null) {
      return _model!;
    } else {
      throw Exception('There is no data');
    }
  }
}
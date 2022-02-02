//import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
//import 'package:mandob_moshtarayat/generated/l10n.dart';
//import 'package:mandob_moshtarayat/module_home/response/sub_categories_response.dart';
//import 'package:mandob_moshtarayat/utils/images/images.dart';
//
//class SubCategoriesModel extends DataModel {
//  late String productCategoryName;
//  late int subCategoriesID;
//  late String productCategoryImage;
//  late List<SubcategoriesLevel2> productCategoriesLevel2;
//  List<SubCategoriesModel> _subCategories = [];
//
//  SubCategoriesModel(
//      {required this.subCategoriesID,
//      required this.productCategoryName,
//      required this.productCategoryImage,
//      required this.productCategoriesLevel2});
//
//  SubCategoriesModel.withData(List<Data> data) {
//    data.forEach((element) {
//      _subCategories.add(SubCategoriesModel(
//        subCategoriesID: element.id ?? -1,
//          productCategoryName: element.productCategoryName ?? S.current.unknown,
//          productCategoryImage:
//              element.productCategoryImage?.image ?? ImageAsset.PLACEHOLDER,
//          productCategoriesLevel2:
//              _secondaryCategories(element.productCategoriesLevel2 ?? [])));
//    });
//  }
//
//  List<SubcategoriesLevel2> _secondaryCategories(
//      List<ProductCategoriesLevel2> cats) {
//    List<SubcategoriesLevel2> result = [];
//    cats.forEach((element) {
//      result.add(SubcategoriesLevel2(
//          name: element.productCategoryName ?? S.current.unknown,
//          image: element.productCategoryImage?.image ?? ImageAsset.PLACEHOLDER,
//          id: element.id ?? -1));
//    });
//    return result;
//  }
//
//  List<SubCategoriesModel> get data => _subCategories;
//}
//
//class SubcategoriesLevel2 {
//  int id;
//  String image;
//  String name;
//
//  SubcategoriesLevel2(
//      {required this.id, required this.image, required this.name});
//}

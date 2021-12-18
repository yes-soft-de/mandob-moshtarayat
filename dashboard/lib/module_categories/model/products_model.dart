import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/store_products_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/images/images.dart';

//class ProductsModel extends DataModel {
//  int id = -1;
//  String productName = '';
//  String productImage = '';
//  num productPrice = 0;
//  int storeOwnerProfileID = -1;
//  int storeProductCategoryID = -1;
//
//  List<ProductsModel> _model = [];
//
//  ProductsModel(
//      {required this.id,
//      required this.productName,
//      required this.productImage,
//      required this.productPrice,
//      required this.storeOwnerProfileID,
//      required this.storeProductCategoryID});
//
//  ProductsModel.withData(List<Data> data) : super.withData() {
//    _model = [];
//    for (var element in data) {
//      _model.add(ProductsModel(
//          id: element.id ?? -1,
//          productName: element.productName ?? S.current.productCategory,
//          productImage: element.productImage ?? '',
//          productPrice: element.productPrice ?? 0,
//          storeOwnerProfileID: element.storeOwnerProfileID ?? -1,
//          storeProductCategoryID: element.storeProductCategoryID ?? -1));
//    }
//  }
//  List<ProductsModel> get data => _model;
//}
class ProductsModel extends DataModel{
  int  id = -1;
  String productName = '';
  ImageUrl productImage = ImageUrl();
  num productPrice = 0;
  num discount = 0;
  int storeProductCategoryID = -1;

  List <ProductsModel> _model = [];

  ProductsModel({required this.id,required this.productName,required this.productImage,required this.productPrice,
    required  this.discount,
    required this.storeProductCategoryID});

  ProductsModel.withData(List <Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(ProductsModel(
          id:element.id ?? -1,
          productName: element.productName ?? S.current.productCategory,
          productImage : element.productImage ??ImageUrl(image:ImageAsset.PLACEHOLDER ),
          productPrice : element.productPrice ?? 0,
          discount:element.discount ?? 0,
          storeProductCategoryID: element.storeProductCategoryID ?? -1
      ));
    }
  }
  List<ProductsModel> get data => _model;
}
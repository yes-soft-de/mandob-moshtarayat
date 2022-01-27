import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_categories/response/store_products_response.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class ProductsModel extends DataModel{
  int  id = -1;
  bool  levelOne = false;
  bool  levelTwo = false;
  String productName = '';
  ImageUrl productImage = ImageUrl();
  num productPrice = 0;
  num discount = 0;
  num productQuantity = 0;
  int storeProductCategoryID = -1;
  CategoryLink? categoryLink;

  List <ProductsModel> _model = [];

  ProductsModel({required this.id,required this.productName,required this.productImage,required this.productPrice,
    required  this.discount,
    required this.storeProductCategoryID ,required this.productQuantity ,required this.levelOne ,required this.levelTwo,this.categoryLink});

  ProductsModel.withData(List <Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(ProductsModel(
        id:element.id ?? -1,
        productQuantity: element.productQuantity ?? 0,
        productName: element.productName ?? S.current.productCategory,
        productImage : element.productImage ??ImageUrl(image:ImageAsset.PLACEHOLDER ),
        productPrice : element.productPrice ?? 0,
          discount:element.discount ?? 0,
        storeProductCategoryID: element.storeProductCategoryID ?? -1,
        levelOne: element.isLevelOne ??false,
        levelTwo: element.isLevelTwo ??false,
        categoryLink: element.categoryLink
      ));
    }
  }
  List<ProductsModel> get data => _model;
}
import 'package:mandob_moshtarayat/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_products/response/products_details_response.dart';

class ProductsDetailsModel extends DataModel {
  late int id;
  late String productName;
  late String productImage;
  late num productPrice;
  late int storeOwnerProfileID;
  late int storeProductCategoryID;
  late String storeOwnerName;
  late String image;
  late String phone;
  late String? branchName;
  late num deliveryCost;
  late String discount;
  late String? description;
  late num rate;
  late String soldCount;
  late ProductsDetailsModel _model;
  ProductsDetailsModel(
      {required this.id,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.storeOwnerProfileID,
      required this.storeProductCategoryID,
      required this.storeOwnerName,
      required this.image,
      required this.phone,
      required this.branchName,
      required this.deliveryCost,
      required this.discount,
      required this.description,
      required this.rate,
      required this.soldCount
      });

  ProductsDetailsModel.withData(Data data){
    _model = ProductsDetailsModel(
      soldCount: data.soldCount ?? '0',
      rate: num.parse(data.rate ?? '0'),
      description: data.description ?? '',
      id: data.id ?? -1,
      productName: data.productName ?? S.current.unknown,
      productPrice: data.productPrice ?? 0,
      discount: data.discount ?? '0',
      storeOwnerProfileID: data.storeOwnerProfileID ?? 0,
      storeProductCategoryID: data.storeProductCategoryID ?? 0,
      image: data.image ?? '',
      storeOwnerName: data.storeOwnerName ?? '',
      deliveryCost: data.deliveryCost ?? 0,
      productImage: data.productImage ?? '',
      phone: data.phone ?? '',
      branchName: data.branchName ?? '',
    );
  }

  ProductsDetailsModel get data => _model;
}

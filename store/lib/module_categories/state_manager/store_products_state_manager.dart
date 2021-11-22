import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_categories_model.dart';
import 'package:mandob_moshtarayat/module_categories/model/products_model.dart';
import 'package:mandob_moshtarayat/module_categories/request/create_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/request/update_product_request.dart';
import 'package:mandob_moshtarayat/module_categories/service/store_categories_service.dart';
import 'package:mandob_moshtarayat/module_categories/ui/screen/store_products_screen.dart';
import 'package:mandob_moshtarayat/module_categories/ui/state/product_store/product_store_state.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class StoreProductsStateManager {
  final CategoriesService _categoriesService;

  final AuthService _authService;
  final ImageUploadService _imageUploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreProductsStateManager(
      this._categoriesService, this._authService,this._imageUploadService);

  void getStoreProducts(StoreProductScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
        _categoriesService.getStoreProducts().then((products){
          if (products.hasError) {
            _stateSubject.add(
                ProductStoreState(screenState, null, error: products.error));
          } else if (products.isEmpty) {
            _stateSubject.add(ProductStoreState(screenState, [],));
          }
          else {
            ProductsModel storeProducts = products as ProductsModel;
            _stateSubject.add(ProductStoreState(screenState, storeProducts.data));
          }
        });
      }

}

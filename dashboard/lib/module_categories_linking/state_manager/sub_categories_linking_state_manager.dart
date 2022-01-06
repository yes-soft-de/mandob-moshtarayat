import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/service/linking_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/sub_categories_linking_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/state/sub_categories_linking/sub_categories_linking_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';

@injectable
class SubCategoriesLinkingStateManager {
  final LinkingService _categoriesService;
  final AuthService _authService;
  final ImageUploadService _imageUploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  SubCategoriesLinkingStateManager(
      this._categoriesService, this._authService, this._imageUploadService);

  void getSubCategoriesLinking(SubCategoriesLinkingScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getSubCategoriesLinking().then((value) {
      if (value.hasError) {
        _stateSubject.add(SubCategoriesLinkingLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(SubCategoriesLinkingLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        SubCategoriesModel model = value as SubCategoriesModel;
        _stateSubject
            .add(SubCategoriesLinkingLoadedState(screenState, model.data));
      }
    });
  }

  // void updateProduct(
  //     StoreProductScreenState screenState, UpdateProductRequest request) {
  //   _stateSubject.add(LoadingState(screenState));
  //   if (!request.productImage!.contains('/original-image/')) {
  //     _imageUploadService.uploadImage(request.productImage ?? '').then((value) {
  //       if (value == null) {
  //         getProductCategory(screenState, request.storeOwnerProfileID ?? -1);
  //         CustomFlushBarHelper.createError(
  //             title: S.current.warnning,
  //             message: S.current.errorUploadingImages)
  //           ..show(screenState.context);
  //       } else {
  //         request.productImage = value;
  //         _categoriesService.updateProduct(request).then((value) {
  //           if (value.hasError) {
  //             getProductCategory(
  //                 screenState, request.storeOwnerProfileID ?? -1);
  //             CustomFlushBarHelper.createError(
  //                 title: S.current.warnning, message: value.error ?? '')
  //               ..show(screenState.context);
  //           } else {
  //             getProductCategory(
  //                 screenState, request.storeOwnerProfileID ?? -1);
  //             CustomFlushBarHelper.createSuccess(
  //                 title: S.current.warnning,
  //                 message: S.current.categoryCreatedSuccessfully)
  //               ..show(screenState.context);
  //           }
  //         });
  //       }
  //     });
  //   } else {
  //     _categoriesService.updateProduct(request).then((value) {
  //       if (value.hasError) {
  //         getProductCategory(screenState, request.storeOwnerProfileID ?? -1);
  //         CustomFlushBarHelper.createError(
  //             title: S.current.warnning, message: value.error ?? '')
  //           ..show(screenState.context);
  //       } else {
  //         getProductCategory(screenState, request.storeOwnerProfileID ?? -1);
  //         CustomFlushBarHelper.createSuccess(
  //             title: S.current.warnning,
  //             message: S.current.categoryCreatedSuccessfully)
  //           ..show(screenState.context);
  //       }
  //     });
  //   }
  // }

}

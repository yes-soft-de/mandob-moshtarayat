import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_stores/service/stores_service.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/stores_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/stores_empty_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/stores_error_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/stores_loaded_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/stores_loading_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/stores_state.dart';
//import 'package:mandob_moshtarayat/module_home/model/productsByCategoriesModel.dart';
//import 'package:mandob_moshtarayat/module_home/model/subCategoriesModel.dart';
//import 'package:mandob_moshtarayat/module_home/ui/state/stores_loaded_filters_state.dart';
//import 'package:mandob_moshtarayat/utils/models/store_category.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/service/home_service.dart';
//import 'package:mandob_moshtarayat/module_home/ui/screen/stores_screen.dart';
//import 'package:mandob_moshtarayat/module_home/ui/state/stores_empty_state.dart';
//import 'package:mandob_moshtarayat/module_home/ui/state/stores_error_state.dart';
//import 'package:mandob_moshtarayat/module_home/ui/state/stores_loaded_state.dart';
//import 'package:mandob_moshtarayat/module_home/ui/state/stores_loading_state.dart';
//import 'package:mandob_moshtarayat/module_home/ui/state/stores_state.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
//import 'package:mandob_moshtarayat/utils/models/product.dart';

@injectable
class StoresStateManager {
  final StoresService _homeService;

  StoresStateManager(this._homeService);

  final PublishSubject<StoresState> stateSubject = PublishSubject<StoresState>();
  final PublishSubject<AsyncSnapshot<Object?>> _productSubject =
  PublishSubject();
  Stream<StoresState> get stateStream => stateSubject.stream;
  Stream<AsyncSnapshot<Object?>> get productsStream => _productSubject.stream;


  void getStoreAndCat(StoresScreenState screenState){
    stateSubject.add(StoresLoadingState(screenState));
    _homeService.getCategoriesAndStores().then((value) {
      if(value.hasErrors)
        stateSubject.add(StoresErrorState(screenState,[]));
      else if(value.isEmpty){
        stateSubject.add(StoresEmptyState(screenState, S.current.homeDataEmpty));
      }
      else{
        _homeService.getLastProducts().then((products) {
          if(products.hasError)
            stateSubject.add(StoresErrorState(screenState,[]));
          else if(products.isEmpty){
            stateSubject.add(StoresLoadedState(screenState,bestStores: value.data.storeModel,categories:value.data.storeCategory ,topProducts: []));
          }else{
            stateSubject.add(StoresLoadedState(screenState,bestStores: value.data.storeModel,categories:value.data.storeCategory ,topProducts: products.models));
          }
        });
      }
    });
  }

//  void getHomeData(HomeScreenState screenState,[bool loading = true]) {
//    if (loading){
//      stateSubject.add(HomeLoadingState(screenState));
//    }
//    _homeService.getHomeData().then((value) {
//      if (value.isEmpty) {
//        stateSubject.add(HomeEmptyState(screenState, S.current.homeDataEmpty));
//      } else if (value.hasData) {
//        var data = value.data;
//        stateSubject.add(HomeLoadedState(screenState,
//            topProducts: data.topWanted,
//            categories: data.storeCategory,
//            bestStores: data.storeModel));
//        if (value.hasErrors) {
//          CustomFlushBarHelper.createError(
//                  title: S.current.warnning, message: value.errors[0])
//              .show(screenState.context)
//              .whenComplete(() {
//            if (value.errors.length == 2) {
//              CustomFlushBarHelper.createError(
//                      title: S.current.warnning,
//                      message: value.errors[1],
//                      timeout: 3)
//                  .show(screenState.context);
//            }
//          });
//        }
//      } else {
//        stateSubject.add(HomeErrorState(screenState, value.errors));
//      }
//    });
//  }
//  void getHomeFilterData(HomeScreenState screenState,String categoriesId,List<StoreCategoryModel> categories) {
//    _homeService.getSubCategories(categoriesId).then((value) {
//      if (value.hasError){
//        CustomFlushBarHelper.createError(
//            title: S.current.warnning, message: value.error ?? '')
//            .show(screenState.context);
//        getHomeData(screenState,false);
//      } else if (value.isEmpty){
//        stateSubject.add(HomeEmptyState(screenState, S.current.homeDataEmpty));
//      }
//      else {
//        SubCategoriesModel model = value as SubCategoriesModel;
//        stateSubject.add(HomeLoadedFilterState(screenState,categories: categories,subCategories: model.data));
//      }
//    });
//  }
//  void getFilteredProducts(HomeScreenState screenState,String categoriesId) {
//    _productSubject.add(AsyncSnapshot.waiting());
//    _homeService.getCategoriesProducts(categoriesId).then((value) {
//      if (value.hasError){
//        _productSubject.add(AsyncSnapshot.waiting());
//      } else if (value.isEmpty){
//        _productSubject.add(AsyncSnapshot.nothing());
//      }
//      else {
//        ProductsByCategoriesModel model = value as ProductsByCategoriesModel;
//        _productSubject.add(AsyncSnapshot.withData(ConnectionState.done, model.data));
//      }
//    });
//  }
//  void getSubCategoriesProducts(HomeScreenState screenState,String categoriesId) {
//    _productSubject.add(AsyncSnapshot.waiting());
//    _homeService.getSubCategoriesProducts(categoriesId).then((value) {
//      if (value.hasError){
//        _productSubject.add(AsyncSnapshot.waiting());
//      } else if (value.isEmpty){
//        _productSubject.add(AsyncSnapshot.nothing());
//      }
//      else {
//        ProductsByCategoriesModel model = value as ProductsByCategoriesModel;
//        _productSubject.add(AsyncSnapshot.withData(ConnectionState.done, model.data));
//      }
//    });
//  }
//  void getMainCategoryProducts(HomeScreenState screenState,String categoriesId) {
//    _productSubject.add(AsyncSnapshot.waiting());
//    _homeService.getMainCategoryProducts(categoriesId).then((value) {
//      if (value.hasError){
//        _productSubject.add(AsyncSnapshot.waiting());
//      } else if (value.isEmpty){
//        _productSubject.add(AsyncSnapshot.nothing());
//      }
//      else {
//        ProductsByCategoriesModel model = value as ProductsByCategoriesModel;
//        _productSubject.add(AsyncSnapshot.withData(ConnectionState.done, model.data));
//      }
//    });
//  }
}

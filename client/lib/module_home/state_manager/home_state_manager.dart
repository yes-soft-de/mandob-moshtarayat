// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_home/model/products_by_categories_model.dart';
import 'package:mandob_moshtarayat/module_home/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_favorite_loaded_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loaded_filters_state.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/service/home_service.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_empty_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_error_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loaded_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loading_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';

@injectable
class HomeStateManager {
  final HomeService _homeService;

  HomeStateManager(this._homeService);

  final PublishSubject<HomeState> stateSubject = PublishSubject<HomeState>();
  final PublishSubject<AsyncSnapshot<Object?>> _productSubject =
      PublishSubject();
  Stream<HomeState> get stateStream => stateSubject.stream;
  Stream<AsyncSnapshot<Object?>> get productsStream => _productSubject.stream;

  void getHomeData(HomeScreenState screenState, [bool loading = true]) {
    if (loading) {
      stateSubject.add(HomeLoadingState(screenState));
    }
    _homeService.getHomeData().then((value) {
      if (value.isEmpty) {
        stateSubject.add(HomeEmptyState(screenState, S.current.homeDataEmpty));
      } else if (value.hasData) {
        var data = value.data;
        stateSubject.add(HomeLoadedState(screenState,
            favorite: data.favorite,
            categories: data.storeCategory,
            favoriteStore: data.getFullStores()));
        if (value.hasErrors) {
          CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.errors[0])
              .show(screenState.context);
        }
      } else {
        stateSubject.add(HomeErrorState(screenState, value.errors));
      }
    });
  }

  void getHomeFilterData(HomeScreenState screenState, String categoriesId,
      List<StoreCategoryModel> categories) {
    _homeService.getSubCategories(categoriesId).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
        getHomeData(screenState, false);
      } else if (value.isEmpty) {
        stateSubject.add(HomeLoadedFilterState(screenState,
            categories: categories, subCategories: []));
      } else {
        SubCategoriesModel model = value as SubCategoriesModel;
        stateSubject.add(HomeLoadedFilterState(screenState,
            categories: categories, subCategories: model.data));
      }
    });
  }

  void getHomeFavoriteData(HomeScreenState screenState, String categoriesId) {
    _homeService.getSubCategories(categoriesId).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
        getHomeData(screenState, false);
      } else if (value.isEmpty) {
        stateSubject
            .add(HomeFavoriteLoadedState(screenState, subCategories: []));
      } else {
        SubCategoriesModel model = value as SubCategoriesModel;
        stateSubject.add(
            HomeFavoriteLoadedState(screenState, subCategories: model.data));
      }
    });
  }

  void getProductsByStore(HomeScreenState screenState, String storeID) {
    _productSubject.add(AsyncSnapshot.waiting());
    _homeService.getProductsByStore(storeID).then((value) {
      if (value.hasError) {
        _productSubject.add(AsyncSnapshot.waiting());
      } else if (value.isEmpty) {
        _productSubject.add(AsyncSnapshot.nothing());
      } else {
        ProductsByCategoriesModel model = value as ProductsByCategoriesModel;
        _productSubject
            .add(AsyncSnapshot.withData(ConnectionState.done, model.data));
      }
    });
  }

  void getFilteredProducts(HomeScreenState screenState, String categoriesId) {
    _productSubject.add(AsyncSnapshot.waiting());
    _homeService.getCategoriesProducts(categoriesId).then((value) {
      if (value.hasError) {
        _productSubject.add(AsyncSnapshot.waiting());
      } else if (value.isEmpty) {
        _productSubject.add(AsyncSnapshot.nothing());
      } else {
        ProductsByCategoriesModel model = value as ProductsByCategoriesModel;
        _productSubject
            .add(AsyncSnapshot.withData(ConnectionState.done, model.data));
      }
    });
  }

  void getSubCategoriesProducts(
      HomeScreenState screenState, String categoriesId) {
    _productSubject.add(AsyncSnapshot.waiting());
    _homeService.getSubCategoriesProducts(categoriesId).then((value) {
      if (value.hasError) {
        _productSubject.add(AsyncSnapshot.waiting());
      } else if (value.isEmpty) {
        _productSubject.add(AsyncSnapshot.nothing());
      } else {
        ProductsByCategoriesModel model = value as ProductsByCategoriesModel;
        _productSubject
            .add(AsyncSnapshot.withData(ConnectionState.done, model.data));
      }
    });
  }

  void getMainCategoryProducts(
      HomeScreenState screenState, String categoriesId) {
    _productSubject.add(AsyncSnapshot.waiting());
    _homeService.getMainCategoryProducts(categoriesId).then((value) {
      if (value.hasError) {
        _productSubject.add(AsyncSnapshot.waiting());
      } else if (value.isEmpty) {
        _productSubject.add(AsyncSnapshot.nothing());
      } else {
        ProductsByCategoriesModel model = value as ProductsByCategoriesModel;
        _productSubject
            .add(AsyncSnapshot.withData(ConnectionState.done, model.data));
      }
    });
  }
}

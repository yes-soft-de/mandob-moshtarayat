import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/hive/favorite_store_category.dart';
import 'package:mandob_moshtarayat/module_home/model/products_by_categories_model.dart';
import 'package:mandob_moshtarayat/module_home/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/favorite_app_bar.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/product_component.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/sub_category_card.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class HomeFavoriteLoadedState extends HomeState {
  HomeScreenState screenState;
  List<SubCategoriesModel> subCategories;
  HomeFavoriteLoadedState(this.screenState, {required this.subCategories})
      : super(screenState);

  String subCategory = '';
  String? subCategoryLevel2ID;
  List<SubcategoriesLevel2> catsLevel2 = [];

  @override
  Widget getUI(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return screenState.getHomeData();
      },
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          FavoriteHomeAppBar(
            categoriesCallback: (categoriesID,categoriesLevel2) {
              subCategory = categoriesID;
              subCategoryLevel2ID = null;
              catsLevel2 = categoriesLevel2;
              screenState.getSubCategoriesProducts(categoriesID);
              screenState.refresh();
            },
            categoryName: getIt<FavoriteHiveHelper>().getFavoriteCategoryInfo()?.storeName ?? S.current.unknown,
            categoryImage: getIt<FavoriteHiveHelper>().getFavoriteCategoryInfo()?.image ?? S.current.unknown,
            categories: subCategories,
          ),
          SizedBox(
            height: 65,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              children: _getSubCategoriesLevel2(),
            ),
          ),
          Checked(
            checked: screenState.snapshot.hasData &&
                screenState.snapshot.connectionState != ConnectionState.waiting,
            child: Lottie.asset(LottieAsset.LOADING_CART,
                repeat: true, width: 125, height: 125),
            checkedWidget: Column(
              children: _getProductsByCategories(),
            ),
          ),
          const SizedBox(
            height: 75,
          ),
        ],
      ),
    );
  }

  List<Widget> _getSubCategoriesLevel2() {
    List<Widget> widgets = [];
    catsLevel2.forEach((element) {
      widgets.add(
        SubCategoryCard(
            id: element.id.toString(),
            title: element.name,
            selected: subCategoryLevel2ID == element.id.toString(),
            icon: element.image == '' ? Icons.category : null,
            image: element.image,
            onTap: (selected) {
              subCategoryLevel2ID = selected;
              screenState.getProducts(selected);
              screenState.refresh();
            }),
      );
    });
    return widgets;
  }

  List<Widget> _getProductsByCategories() {
    List<Widget> widgets = [];
    if (!screenState.snapshot.hasData) return widgets;
    screenState.snapshot.data.forEach((ProductsByCategoriesModel element) {
      widgets.add(ProductComponent(
        storeName: element.storeName,
        productId: element.id.toString(),
        storeId: element.storeOwnerProfileID.toString(),
        image: element.image,
        title: element.productName,
        sold: element.soldCount,
        discount: element.discount,
        rating: element.rate.toDouble(),
        description: element.description,
        price: element.productPrice.toStringAsFixed(2),
      ));
    });
    return widgets;
  }
}

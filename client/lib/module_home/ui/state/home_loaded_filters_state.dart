import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/model/productsByCategoriesModel.dart';
import 'package:mandob_moshtarayat/module_home/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat/module_home/model/top_wanted_products_model.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/home_app_bar.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/product_card.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/product_component.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/sub_category_card.dart';
import 'package:mandob_moshtarayat/module_products/products_routes.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/customIcon/mandob_icons_icons.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';

class HomeLoadedFilterState extends HomeState {
  HomeScreenState screenState;
  List<StoreCategoryModel> categories;
  List<SubCategoriesModel> subCategories;

  HomeLoadedFilterState(this.screenState,
      {required this.categories, required this.subCategories})
      : super(screenState);

  String categoryID = S.current.home;
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
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          CustomHomeAppBar(
            categoriesCallback: (categoriesID) {
              if ('0' == categoriesID) {
                screenState.getHomeData(false);
                screenState.refresh();
              } else {
                categoryID = categoriesID;
                subCategory = '';
                subCategoryLevel2ID = null;
                screenState.getCategories(categoriesID, categories);
                screenState.refresh();
              }
            },
            categories: categories,
          ),
          Container(
            height: 65,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              children: _getSubCategories(),
            ),
          ),
          Container(
            height: 65,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              children: _getSubCategoriesLevel2(),
            ),
          ),
          Checked(
            checked: screenState.snapshot.hasData && screenState.snapshot.connectionState != ConnectionState.waiting,
            child: Lottie.asset(LottieAsset.LOADING_CART,repeat: true,width: 125,height: 125),
            checkedWidget: Column(
              children: _getProductsByCategories(),
            ),
          ),
          SizedBox(
            height: 75,
          ),
        ],
      ),
    );
  }

  List<Widget> _getSubCategories() {
    List<Widget> widgets = [];
    subCategories.forEach((element) {
      widgets.add(
        SubCategoryCard(
            id: element.productCategoryName,
            title: element.productCategoryName,
            selected: subCategory == element.productCategoryName,
            icon: Icons.phone_android_rounded,
            onTap: (selected) {
              subCategory = selected;
              catsLevel2 = element.productCategoriesLevel2;
              subCategoryLevel2ID = null;
              screenState.refresh();
            }),
      );
    });
    return widgets;
  }

  List<Widget> _getSubCategoriesLevel2() {
    List<Widget> widgets = [];
    catsLevel2.forEach((element) {
      widgets.add(
        SubCategoryCard(
            id: element.id.toString(),
            title: element.name,
            selected: subCategoryLevel2ID == element.id.toString(),
            icon: Icons.phone_android_rounded,
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
        productId: element.id.toString(),
        storeId: element.storeOwnerProfileID.toString(),
        image: element.image,
        title: element.productName,
        sold: element.soldCount,
        discount: element.discount,
        rating: element.rate.toDouble(),
        description: element.description,
      ));
    });
    return widgets;
  }
}

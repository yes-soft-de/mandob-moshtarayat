import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_stores/model/productsByCategoriesModel.dart';
import 'package:mandob_moshtarayat/module_stores/model/top_wanted_products_model.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/stores_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/stores_loaded_filters_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/stores_state.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/home_app_bar.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/product_card.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/show_all.dart';
import 'package:mandob_moshtarayat/module_stores/model/top_wanted_products_model.dart';
import 'package:mandob_moshtarayat/module_stores/stores_routes.dart';
import 'package:mandob_moshtarayat/module_stores/ui/screen/stores_screen.dart';
import 'package:mandob_moshtarayat/module_stores/ui/state/stores_state.dart';
import 'package:mandob_moshtarayat/utils/customIcon/custom_icons.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
//import 'package:mandob_moshtarayat/utils/models/store.dart';
//import 'package:mandob_moshtarayat/utils/models/store_category.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

class StoresLoadedState extends StoresState {
  StoresScreenState screenState;
  List<TopWantedProductsModel> topProducts;
  List<StoreCategoryModel> categories;
  List<StoreModel> bestStores;

  StoresLoadedState(this.screenState,
      {
        required this.topProducts,
        required this.categories,
        required this.bestStores})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
//          CustomHomeAppBar(categoriesCallback: (categoriesId){
//            if (categoriesId != '0') {
//              screenState.getCategories(categoriesId, categories);
//              screenState.getMainCategoryProducts(categoriesId);
//              screenState.refresh();
//            }
//          },categories: categories,),

          Hider(
            active: topProducts.isNotEmpty,
            child: ListTile(
              leading: Icon(
                CustomIcon.top_product,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
              title: Text(
                S.of(context).lastProduct,
                style: StyleText.categoryStyle,
              ),
              trailing: showAll(context),
            ),
          ),
          Hider(
            active: topProducts.isNotEmpty,
            child: SizedBox(
              height: 125,
              child: ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                children: _getTopProducts(topProducts),
              ),
            ),
          ),
        Hider(
          active: bestStores.isNotEmpty,
          child: ListTile(
            leading: Icon(
              CustomIcon.top_store,
              color: Theme.of(context).primaryColor,
              size: 18,
            ),
            title: Text(
              S.of(context).bestStore,
              style: StyleText.categoryStyle,
            ),
            trailing: showAll(context),
          ),
        ),
        Hider(
          active: bestStores.isNotEmpty,
          child: SizedBox(
            height: 125,
            child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              children: getBestStores(bestStores),
            ),
          ),
        ),
        Hider(
          active: false,
          child: ListTile(
            leading: Icon(
              CustomIcon.near_me,
              color: Theme.of(context).primaryColor,
              size: 18,
            ),
            title: Text(
              S.of(context).nearbyStore,
              style: StyleText.categoryStyle,
            ),
            trailing: showAll(context),
          ),
        ),
        Hider(
          active: false,
          child: SizedBox(
            height: 125,
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (_, index) {
                return HomeCard(
                    title: 'متجر',
                    image:
                    'https://media-cdn.tripadvisor.com/media/photo-s/17/75/3f/d1/restaurant-in-valkenswaard.jpg');
              },
            ),
          ),
        ),
        Hider(
          active: categories.isNotEmpty,
          child: ListTile(
            leading: Icon(
              Icons.sort,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              S.of(context).categories,
              style: StyleText.categoryStyle,
            ),
          ),
        ),
        Hider(
          active: categories.isNotEmpty,
          child: GridView(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                childAspectRatio:
                (MediaQuery.of(context).size.width / 2) / 135),
            children: getCategories(categories),
          ),
        ),
        SizedBox(
          height: 75,
        ),
      ],
    );
  }

  List<Widget> _getTopProducts(List<TopWantedProductsModel> topProducts) {
    if (topProducts.isEmpty) return [];
    List<HomeCard> top = [];
    topProducts.forEach((element) {
      top.add(HomeCard(
        title: element.title,
        image: element.image,
        onTap: () {
//          Navigator.of(screenState.context).pushNamed(
//              StoreRoutes.STORE_PRODUCTS,
//              arguments: StoreModel(
//                  deliveryCost: element.deliveryCost,
//                  id: element.ownerId,
//                  storeOwnerName: element.storeName,
//                  image: element.storeImage,
//                  privateOrders: false,
//                  hasProducts: true));
        },
      ));
    });
    return top;
  }

  List<Widget> getCategories(List<StoreCategoryModel> categories) {
    if (categories.isEmpty) return [];
    List<HomeCard> cats = [];
    categories.forEach((element) {
      cats.add(HomeCard(
        title: element.storeCategoryName,
        image: element.image,
        onTap: () {
//          Navigator.of(screenState.context)
//              .pushNamed(StoreRoutes.STORE_LIST_SCREEN, arguments: element);
        },
      ));
    });
    return cats;
  }

  List<Widget> getBestStores(List<StoreModel> stores) {
    if (stores.isEmpty) return [];
    List<HomeCard> bestStoresCards = [];
    stores.forEach((element) {
      bestStoresCards.add(HomeCard(
        title: element.storeOwnerName,
        image: element.image,
        onTap: () {
//          if (element.hasProducts && element.privateOrders) {
//            // Navigator.of(screenState.context).pushNamed(StoreRoutes.STORE_PRODUCTS,arguments: element);
//            showModalBottomSheet(
//                shape: RoundedRectangleBorder(
//                    borderRadius:
//                    BorderRadius.vertical(top: Radius.circular(10))),
//                context: screenState.context,
//                builder: (context) {
//                  return OrderType(element);
//                });
//          } else if (element.hasProducts) {
////            Navigator.of(screenState.context)
////                .pushNamed(StoreRoutes.STORE_PRODUCTS, arguments: element);
//          } else {
////            Navigator.of(screenState.context)
////                .pushNamed(ServicesRoutes.PRIVATE_ORDER, arguments: element);
//          }
        },
      ));
    });
    return bestStoresCards;
  }
}

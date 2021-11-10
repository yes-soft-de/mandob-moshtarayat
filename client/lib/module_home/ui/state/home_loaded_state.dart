import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/model/top_wanted_products_model.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loaded_filters_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/home_app_bar.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/product_card.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/show_all.dart';
import 'package:mandob_moshtarayat/module_our_services/services_routes.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_list/order_type.dart';
import 'package:mandob_moshtarayat/utils/customIcon/custom_icons.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

class HomeLoadedState extends HomeState {
  HomeScreenState screenState;
  List<TopWantedProductsModel> topProducts;
  List<StoreCategoryModel> categories;
  List<StoreModel> bestStores;

  HomeLoadedState(this.screenState,
      {required this.topProducts,
        required this.categories,
        required this.bestStores})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return screenState.getHomeData();
      },
      child: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          CustomHomeAppBar(categoriesCallback: (title){
            if (title != S.current.home) {
              screenState.currentState = HomeLoadedFilterState(screenState,categories: categories,topProducts: topProducts,bestStores: bestStores);
              screenState.refresh();
            }
          },categories: categories,),
          ListTile(
            leading: Icon(
              CustomIcon.our_service,
              color: Theme.of(context).primaryColor,
              size: 18,
            ),
            title: Text(
              S.of(context).ourService,
              style: StyleText.categoryStyle,
            ),
          ),
          SizedBox(
            height: 125,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                HomeCard(
                  title: S.of(context).deliverForMe,
                  image: ImageAsset.SEND_ON_ME,
                  onTap: () {
                    Navigator.of(context).pushNamed(ServicesRoutes.SEND_IT);
                  },
                ),
              ],
            ),
          ),
          Hider(
            active: topProducts.isNotEmpty,
            child: ListTile(
              leading: Icon(
                CustomIcon.top_product,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
              title: Text(
                S.of(context).mostSoldProduct,
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
      ),
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
          Navigator.of(screenState.context).pushNamed(
              StoreRoutes.STORE_PRODUCTS,
              arguments: StoreModel(
                  deliveryCost: element.deliveryCost,
                  id: element.ownerId,
                  storeOwnerName: element.storeName,
                  image: element.storeImage,
                  privateOrders: false,
                  hasProducts: true));
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
          Navigator.of(screenState.context)
              .pushNamed(StoreRoutes.STORE_LIST_SCREEN, arguments: element);
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
          if (element.hasProducts && element.privateOrders) {
            // Navigator.of(screenState.context).pushNamed(StoreRoutes.STORE_PRODUCTS,arguments: element);
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(10))),
                context: screenState.context,
                builder: (context) {
                  return OrderType(element);
                });
          } else if (element.hasProducts) {
            Navigator.of(screenState.context)
                .pushNamed(StoreRoutes.STORE_PRODUCTS, arguments: element);
          } else {
            Navigator.of(screenState.context)
                .pushNamed(ServicesRoutes.PRIVATE_ORDER, arguments: element);
          }
        },
      ));
    });
    return bestStoresCards;
  }
}

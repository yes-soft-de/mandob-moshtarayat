import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/model/favorite_categories_model.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/fav_category_card.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/home_app_bar.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/product_card.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/show_all.dart';
import 'package:mandob_moshtarayat/module_our_services/services_routes.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_list/order_type.dart';
import 'package:mandob_moshtarayat/utils/customIcon/custom_icons.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

class HomeLoadedState extends HomeState {
  HomeScreenState screenState;
  List<FavoriteCategoriesModel> favorite;
  List<FavoriteStore> favoriteStore;
  List<StoreCategoryModel> categories;

  HomeLoadedState(
    this.screenState, {
    required this.favorite,
    required this.categories,
    required this.favoriteStore
  }) : super(screenState);

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
          CustomHomeAppBar(
            categoriesCallback: (categoriesId) {
              if (categoriesId != '0') {
                screenState.getCategories(categoriesId, categories);
                screenState.getMainCategoryProducts(categoriesId);
                screenState.refresh();
              }
            },
            categories: categories,
          ),
          // favorite categories
          Hider(
            active: favorite.isNotEmpty,
            child: ListTile(
              leading: Icon(
                Icons.category,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
              title: Text(
                S.of(context).favoriteCategories,
                style: StyleText.categoryStyle,
              ),
              trailing: showAll(context),
            ),
          ),
          Hider(
            active: favorite.isNotEmpty,
            child: SizedBox(
              height: 75,
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                children: _getFavoriteCategories(favorite),
              ),
            ),
          ),
          // stores 
          Hider(
            active: favoriteStore.isNotEmpty,
            child: ListTile(
              leading: Icon(
                CustomIcon.top_store,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
              title: Text(
                S.of(context).favoriteStores,
                style: StyleText.categoryStyle,
              ),
              trailing: showAll(context),
            ),
          ),
          Hider(
            active: favoriteStore.isNotEmpty,
            child: SizedBox(
              height: 125,
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                children: getFavStores(favoriteStore),
              ),
            ),
          ),
          // products 
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
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (_, index) {
                  return const HomeCard(
                      title: 'متجر',
                      image:
                          'https://media-cdn.tripadvisor.com/media/photo-s/17/75/3f/d1/restaurant-in-valkenswaard.jpg');
                },
              ),
            ),
          ), const SizedBox(
            height: 75,
          ),
        ],
      ),
    );
  }

  List<Widget> _getFavoriteCategories(List<FavoriteCategoriesModel> favs) {
    if (favs.isEmpty) return [];
    List<Widget> cats = [];
    favs.forEach((element) {
      cats.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: FavCategoryCard(
          name: element.categoriesName,
        ),
      ));
    });
    return cats;
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

  List<Widget> getFavStores(List<FavoriteStore> stores) {
    if (stores.isEmpty) return [];
    List<HomeCard> bestStoresCards = [];
    stores.forEach((element) {
      bestStoresCards.add(HomeCard(
        title: element.storeName,
        image: element.image,
        onTap: () {
        },
      ));
    });
    return bestStoresCards;
  }
}

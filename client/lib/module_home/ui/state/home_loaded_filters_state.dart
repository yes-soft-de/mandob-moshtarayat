import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/model/top_wanted_products_model.dart';
import 'package:mandob_moshtarayat/module_home/ui/screen/home_screen.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loaded_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_loading_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/state/home_state.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/home_app_bar.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/product_card.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/sub_category_card.dart';
import 'package:mandob_moshtarayat/module_products/products_routes.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';


class HomeLoadedFilterState extends HomeState {
  HomeScreenState screenState;
  List<TopWantedProductsModel> topProducts;
  List<StoreCategoryModel> categories;
  List<StoreModel> bestStores;
  HomeLoadedFilterState(this.screenState,
      {required this.topProducts,
        required this.categories,
        required this.bestStores})
      : super(screenState);

  String title = S.current.home;

  @override
  Widget getUI(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return screenState.getHomeData();
      },
      child: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          CustomHomeAppBar(callback: (title){
            if (S.current.home == title){
              screenState.currentState = HomeLoadedState(screenState, topProducts: topProducts, categories: categories, bestStores: bestStores);
              screenState.refresh();
            }
          },),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                scrollDirection:Axis.horizontal,
                children: [
                  SubCategoryCard(title: S.current.all, selected:title == S.current.all, icon: Icons.home,onTap: (selected){
                    title = selected;
                    screenState.refresh();
                  },),
                  SubCategoryCard(title: 'mobile', selected:title == 'mobile', icon: Icons.phone_android_rounded,onTap: (selected){
                    title = selected;
                    screenState.refresh();
                  }),
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: (){
              Navigator.of(context).pushNamed(ProductsRoutes.PRODUCT_DETAILS_SCREEN);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                child: Row(
                  children: [
                    Expanded(child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Iphone 13 pro',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),textAlign: TextAlign.start,overflow:TextOverflow.ellipsis),
                          SizedBox(height: 8,),
                          Container(
                            constraints: BoxConstraints(
                                maxHeight: 50,
                                maxWidth: 200
                            ),
                            child: Text('Buy new Iphone from us and you will be happy',style: TextStyle(
                              fontSize: 14,
                            ),textAlign: TextAlign.start,),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: 200
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('Rating',style: TextStyle(
                                      fontSize: 13,
                                    ),textAlign: TextAlign.start,overflow:TextOverflow.ellipsis,),
                                    SizedBox(height: 4,),
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: 3,
                                      minRating: 0,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                      },
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Discount',style: TextStyle(
                                      fontSize: 13,
                                    ),textAlign: TextAlign.start,overflow:TextOverflow.ellipsis,),
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Icon(FontAwesomeIcons.percent,size: 12,color: Theme.of(context).primaryColor,),
                                        SizedBox(width: 4,),
                                        Text('10',style: TextStyle(
                                          fontSize: 12,
                                        ),textAlign: TextAlign.start,overflow:TextOverflow.ellipsis,),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Sold',style: TextStyle(
                                      fontSize: 13,
                                    ),textAlign: TextAlign.start,overflow:TextOverflow.ellipsis,),
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Icon(FontAwesomeIcons.shoppingBag,size: 12,color: Theme.of(context).primaryColor,),
                                        SizedBox(width: 4,),
                                        Text('2',style: TextStyle(
                                          fontSize: 12,
                                        ),textAlign: TextAlign.start,overflow:TextOverflow.ellipsis,),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),
                        ],
                      ),
                    )),
                    SizedBox(width: 16,),
                    SizedBox(
                      height: 125,
                      width: 125,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CustomNetworkImage(
                            height: 125,
                            width: 125,
                            imageSource: ImageAsset.PLACEHOLDER,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
}
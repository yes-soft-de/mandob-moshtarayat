import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_our_services/services_routes.dart';
import 'package:mandob_moshtarayat/module_search/model/search_model.dart';
import 'package:mandob_moshtarayat/module_search/ui/screen/search_screen.dart';
import 'package:mandob_moshtarayat/module_search/ui/state/store_list/search_state.dart';
import 'package:mandob_moshtarayat/module_stores/store_routes.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_card.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_list/order_type.dart';
import 'package:mandob_moshtarayat/module_stores/ui/widget/store_products/products_card.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';

class SearchLoadedState extends SearchState {
  SearchScreenState screenState;
  SearchModel search;

  SearchLoadedState(this.screenState, this.search) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.all(0),
      children: [
        ListView(
          padding: EdgeInsets.all(0),
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: getSearchCard(),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  List<Widget> getSearchCard() {
    if (search.isEmpty) return [];
    List<Widget> searchWidget = [];
    if (search.store.isNotEmpty) {
      searchWidget.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
          child: Container(
            color: Theme.of(screenState.context).primaryColor.withOpacity(0.2),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.current.stores.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
          ),
        ),
      );
    }
    search.store.forEach((element) {
      searchWidget.add(StoreCardView(
        rate: element.rating,
        title: element.storeOwnerName,
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
        image: element.image,
      ));
    });
    if (search.product.isNotEmpty) {
      searchWidget.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
          child: Container(
            color: Theme.of(screenState.context).primaryColor.withOpacity(0.2),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.current.products.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
          ),
        ),
      );
    }
    search.product.forEach((element) {
      searchWidget.add(ProductsSearchCard(
        title: element.title,
        image: element.image,
        price: element.price,
        onTap: () {
          Navigator.of(screenState.context)
              .pushNamed(StoreRoutes.STORE_PRODUCTS,
                  arguments: StoreModel(
                    deliveryCost: element.deliveryCost ?? 0,
                    id: element.id,
                    storeOwnerName: element.storeName ?? S.current.storeName,
                    image: element.storeImage ?? '',
                    privateOrders: false,
                    hasProducts: true,
                  ));
        },
      ));
    });
    return searchWidget;
  }
}

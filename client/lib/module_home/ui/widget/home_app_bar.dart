import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/catagories_card.dart';
import 'package:mandob_moshtarayat/module_products/products_routes.dart';
import 'package:mandob_moshtarayat/module_search/search_routes.dart';
import 'package:mandob_moshtarayat/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class CustomHomeAppBar extends StatefulWidget {
  final Function(String) callback;

  CustomHomeAppBar({required this.callback});

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  String title = S.current.home;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      width: double.maxFinite,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:16.0,bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:8.0,left: 8.0),
                  child: SvgPicture.asset(SvgAsset.LOGO_SVG,width: 35),
                ),
                Container(
                  width: 275,
                  child: CustomDeliverySearch(
                    onTap: () {
                      Navigator.pushNamed(context, SearchRoutes.SEARCH_SCREEN);
                    },
                    readOnly: true,
                    hintText: S.of(context).searchFor,
                  ),
                ),
                Expanded(child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(ProductsRoutes.CART_SCREEN);
                    },
                    child: Icon(Icons.shopping_cart,color: Theme.of(context).primaryColor,))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                scrollDirection:Axis.horizontal,
                children: [
                  CategoriesCard(title: S.current.home, selected:title == S.current.home, icon: Icons.home,onTap: (selected){
                    title = selected;
                    widget.callback(title);
                    setState(() {
                    });
                  },),
                  CategoriesCard(title: S.current.electronic, selected:title == S.current.electronic, icon: Icons.cable,onTap: (selected){
                    title = selected;
                    widget.callback(title);
                    setState(() {
                    });
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/catagories_card.dart';
import 'package:mandob_moshtarayat/module_products/products_routes.dart';
import 'package:mandob_moshtarayat/module_search/search_routes.dart';
import 'package:mandob_moshtarayat/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';

class CustomHomeAppBar extends StatefulWidget {
  final Function(String) categoriesCallback;
  final List<StoreCategoryModel> categories;
  CustomHomeAppBar({required this.categoriesCallback ,required this.categories});

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  String id = '0';

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
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.shopping_cart,color:Colors.white),
                      )))),
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
                children: getCategories(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getCategories(){
    List <Widget> widgets = [ CategoriesCard(
      categoryId: '0',
      title: S.current.home, selected:id == '0', icon: Icons.home,onTap: (selected){
      id = selected;
      widget.categoriesCallback(id);
      setState(() {
      });
    },),];
    widget.categories.forEach((element) {
      widgets.add(
        CategoriesCard(
          icon: element.image == '' ? Icons.category : null,
            categoryId: element.id.toString(),
            title: element.storeCategoryName, selected:id == element.id.toString(), image: element.image,onTap: (selected){
          id = selected;
          widget.categoriesCallback(id);
          setState(() {
          });
        }),
      );
    });
    return widgets;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/catagories_card.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat/module_my_notifications/my_notifications_routes.dart';
import 'package:mandob_moshtarayat/module_search/search_routes.dart';
import 'package:mandob_moshtarayat/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:mandob_moshtarayat/utils/models/store_category.dart';

class CustomHomeAppBar extends StatefulWidget {
  final Function(String) categoriesCallback;
  final List<StoreCategoryModel> categories;
  CustomHomeAppBar(
      {required this.categoriesCallback, required this.categories});

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
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: SvgPicture.asset(SvgAsset.LOGO_SVG, width: 35),
                ),
                Container(
                  width: 250,
                  child: CustomDeliverySearch(
                    onTap: () {
                      Navigator.pushNamed(context, SearchRoutes.SEARCH_SCREEN);
                    },
                    readOnly: true,
                    hintText: S.of(context).searchFor,
                  ),
                ),
                Expanded(
                    child: PopupMenuButton<String>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'ar',
                      child: Text("العربية"),
                    ),
                    PopupMenuItem(
                      value: 'en',
                      child: Text("English"),
                    ),
                  ],
                  initialValue: getIt<LocalizationService>().getLanguage(),
                  onSelected: (value) {
                    getIt<LocalizationService>().setLanguage(value);
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: Center(
                          child: Text(
                        getIt<LocalizationService>().getLanguage() == 'ar'
                            ? 'اب'
                            : getIt<LocalizationService>().getLanguage(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.center,
                      ))),
                )),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              MyNotificationsRoutes.MY_NOTIFICATIONS);
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor),
                            child: Center(
                                child: Icon(Icons.notifications,
                                    color: Colors.white))))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                children: getCategories(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getCategories() {
    List<Widget> widgets = [
      CategoriesCard(
        categoryId: '0',
        title: S.current.home,
        selected: id == '0',
        icon: Icons.home,
        onTap: (selected) {
          id = selected;
          widget.categoriesCallback(id);
          setState(() {});
        },
      ),
    ];
    widget.categories.forEach((element) {
      widgets.add(
        CategoriesCard(
            icon: element.image == '' ? Icons.category : null,
            categoryId: element.id.toString(),
            title: element.storeCategoryName,
            selected: id == element.id.toString(),
            image: element.image,
            onTap: (selected) {
              id = selected;
              widget.categoriesCallback(id);
              setState(() {});
            }),
      );
    });
    return widgets;
  }
}

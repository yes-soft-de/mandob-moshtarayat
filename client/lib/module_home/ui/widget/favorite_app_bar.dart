import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/hive/favorite_store_category.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/favourite_screen.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_home/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat/module_home/ui/widget/catagories_card.dart';
import 'package:mandob_moshtarayat/module_my_notifications/my_notifications_routes.dart';
import 'package:mandob_moshtarayat/module_search/search_routes.dart';
import 'package:mandob_moshtarayat/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';

class FavoriteHomeAppBar extends StatefulWidget {
  final Function(String, List<SubcategoriesLevel2>) categoriesCallback;
  final List<SubCategoriesModel> categories;
  final String? categoryName;
  final String? categoryImage;
  const FavoriteHomeAppBar(
      {required this.categoriesCallback,this.categoryImage,this.categoryName,required this.categories});

  @override
  State<FavoriteHomeAppBar> createState() => _FavoriteHomeAppBarState();
}

class _FavoriteHomeAppBarState extends State<FavoriteHomeAppBar> {
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: GestureDetector(
                      onTap: () {
                        if (getIt<AuthService>().isLoggedIn) {
                          showDialog(
                              context: context,
                              builder: (context) => getIt<FavouritScreen>());
                        } else {
                          Navigator.of(context).pushNamed(
                              AuthorizationRoutes.LOGIN_SCREEN,
                              arguments: 0);
                          CustomFlushBarHelper.createError(
                                  title: S.current.warnning,
                                  message: S.current.pleaseLoginToContinue)
                              .show(context);
                        }
                      },
                      child:
                          getIt<FavoriteHiveHelper>().getFavoriteCategory() !=
                                  null
                              ? Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 150,
                                  maxHeight: 65
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:10.0),
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).backgroundColor,
                                            shape: BoxShape.circle
                                          ),
                                          child: ClipOval(
                                            child: Image.network(widget.categoryImage ?? ''),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:4.0),
                                        child: Text(widget.categoryName ?? '',style: const TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                    ],
                                  ),
                              )
                   : SvgPicture.asset(SvgAsset.LOGO_SVG, width: 35)),
                ),
                Expanded(
                  child: CustomDeliverySearch(
                    onTap: () {
                      Navigator.pushNamed(context, SearchRoutes.SEARCH_SCREEN);
                    },
                    readOnly: true,
                    hintText: S.of(context).searchFor,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(MyNotificationsRoutes.MY_NOTIFICATIONS);
                    },
                    child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor),
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.notifications, color: Colors.white),
                        )))),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                physics: const BouncingScrollPhysics(
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
    List<Widget> widgets = [];
    widget.categories.forEach((element) {
      widgets.add(
        CategoriesCard(
            icon: element.productCategoryImage == '' ? Icons.category : null,
            categoryId: element.subCategoriesID.toString(),
            title: element.productCategoryName,
            selected: id == element.subCategoriesID.toString(),
            image: element.productCategoryImage,
            onTap: (selected) {
              id = selected;
              widget.categoriesCallback(id, element.productCategoriesLevel2);
              setState(() {});
            }),
      );
    });
    return widgets;
  }
}
